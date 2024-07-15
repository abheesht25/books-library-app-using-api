//
//  BookViewModel.swift
//  Demo
//
//  Created by Srivastava, Abhisht on 17/06/24.
//

import Foundation
import Combine
import UIKit

class BookViewModel : ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    @Published var favoriteBooks: [Bookdata] = []
    @Published var books : [Bookdata] = []
    
    var numberofbooks : Int {
        return books.count
    }
    
    init(){
        fetchBooks()
    }
    func fetchBooks() {
        guard let url = URL(string: "https://api.itbook.store/1.0/search/xcode") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: BookResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching books: \(error)")
                }
            }, receiveValue: { [weak self] response in
                print("Fetched books: \(response.books)")
                self?.books = response.books
            })
            .store(in: &cancellables)
    }
    
    func toggleFavorite(book: Bookdata) {
            if let index = books.firstIndex(where: { $0.id == book.id }) {
                books[index].isFavorite.toggle()
                updateFavoriteBooks()
            }
        }

        private func updateFavoriteBooks() {
            favoriteBooks = books.filter { $0.isFavorite }
        }
}

struct BookResponse: Codable {
    let books: [Bookdata]
}

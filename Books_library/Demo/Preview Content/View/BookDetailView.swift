//
//  BookDetailView.swift
//  Demo
//
//  Created by Srivastava, Abhisht on 18/06/24.
import SwiftUI

struct BookDetailView: View {
    @ObservedObject var viewModel: BookDetailViewModel
    @EnvironmentObject var BookViewModel: BookViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            AsyncImage(url: URL(string: viewModel.book.image)) { image in
                image.resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
            } placeholder: {
                ProgressView()
            }
            
            Text(viewModel.book.title)
                .font(.largeTitle)
                .bold()
            
            Text("ISBN: \(viewModel.book.isbn13)")
                .font(.title2)
                .foregroundColor(.secondary)
            
            Text(viewModel.book.price)
                .font(.title2)
                .foregroundColor(.secondary)
            
            if let url = URL(string: viewModel.book.url) {
                Link("Buy Now", destination: url)
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 100, height: 50)
                    .background(Color.yellow)
                    .cornerRadius(10)
            } else {
                Text("Invalid URL")
                    .font(.title2)
                    .foregroundColor(.red)
                    .frame(width: 100, height: 50)
                    .background(Color.gray)
                    .cornerRadius(10)
            }
            Button(action: {
                BookViewModel.toggleFavorite(book: viewModel.book)
            }) {
                Text(viewModel.book.isFavorite ? "Remove from Favorites" : "Add to Favorites")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: viewModel.book.isFavorite ? 300 : 200, height: 50)
                    .background(viewModel.book.isFavorite ? Color.red : Color.blue)
                    .cornerRadius(10)
            }
            
            
            Spacer()
        }
        .padding()
        .navigationTitle("Book Details")
//        .onAppear {
//                    viewModel.book.isFavorite = BookViewModel.favoriteBooks.contains { $0.isbn13 == viewModel.book.isbn13 }
//                }
//                .onChange(of: BookViewModel.favoriteBooks) { _ in
//                    viewModel.book.isFavorite = BookViewModel.favoriteBooks.contains { $0.isbn13 == viewModel.book.isbn13 }
//                }
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleBook = Bookdata(
            title: "XCode 4 Unleased",
            subtitle: "Sample Book",
            isbn13: "",
            price: "$29.99",
            image: "https://itbook.store/img/books/9780672333279.png",
            url: "https://itbook.store/books/1234567890123"
        )
        BookDetailView(viewModel: BookDetailViewModel(book: sampleBook))
    }
}

//
//  HomePageView.swift
//  Demo
//
//  Created by Srivastava, Abhisht on 11/06/24.
//

import SwiftUI

struct HomePageView: View {
    @ObservedObject var viewmodel = BookViewModel()
    @State private var selectedBook: Bookdata? = nil
    @State private var showDetailView = false
    @State private var searchQuery: String = ""
    @State private var showFavoritesOnly: Bool = false
    var filteredBooks: [Bookdata] {
        let booksToFilter = showFavoritesOnly ? viewmodel.favoriteBooks : viewmodel.books
        if searchQuery.isEmpty {
            return booksToFilter
            ///for the normal search, if we remove the filter featue
            //            return viewmodel.books
        } else {
            return booksToFilter.filter { $0.title.localizedCaseInsensitiveContains(searchQuery) }
            ///same as above comment, remove above line when remove filter feature
            //            return viewmodel.books.filter { $0.title.localizedCaseInsensitiveContains(searchQuery) }
        }
        
    }
    
    var body : some View {
        NavigationView {
            ZStack {
                Color.yellow.opacity(0.2)
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack(spacing: 15) {
                        Toggle("Show Favorites Only", isOn: $showFavoritesOnly)
                            .padding()
                        ForEach(filteredBooks) { book in
                            NavigationLink(destination: BookDetailView(viewModel: BookDetailViewModel(book: book))) {
                                HStack {
                                    AsyncImage(url: URL(string: book.image)) { image in
                                        image.resizable()
                                            .scaledToFit()
                                            .frame(width: 70, height: 70)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        Text(book.title)
                                            .font(.headline)
                                        Text(book.price)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    
                                    Button(action: {
                                        viewmodel.toggleFavorite(book: book)
                                    }) {
                                        Image(systemName: book.isFavorite ? "heart.fill" : "heart")
                                            .foregroundColor(book.isFavorite ? .red : .gray)
                                    }
                                    .buttonStyle(BorderlessButtonStyle())
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(20)
                                .shadow(radius: 10)
                                .swipeActions {
                                    Button {
                                        print("Muting conversation")
                                    } label: {
                                        Label("Mute", systemImage: "bell.slash.fill")
                                    }
                                    .tint(.indigo)
                                    
                                    Button(role: .destructive) {
                                        print("Deleting conversation")
                                    } label: {
                                        Label("Delete", systemImage: "trash.fill")
                                    }
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 10)
                }
            }
            .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Search Books")
            .navigationTitle("Dashboard")
            .onAppear {
                print("Books count: \(viewmodel.books.count)")
            }
            
        }
    }
    
    
    
    
}



#Preview {
    HomePageView()
}

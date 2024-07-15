//
//  BookDetailViewModel.swift
//  Demo
//
//  Created by Srivastava, Abhisht on 25/06/24.
//

import Foundation
import Combine

class BookDetailViewModel: ObservableObject {
    @Published var book : Bookdata
    
    init(book: Bookdata) {
        self.book = book
    }
}

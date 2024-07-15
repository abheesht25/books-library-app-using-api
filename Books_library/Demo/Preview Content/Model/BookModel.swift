//
//  BookModel.swift
//  Demo
//
//  Created by Srivastava, Abhisht on 17/06/24.
//

import Foundation
struct Bookdata : Identifiable ,Codable {
    let id = UUID()
    //    var id: String { isbn13 }
    let title: String
    let subtitle: String
    let isbn13: String
    let price: String
    let image: String
    let url: String
    var isFavorite: Bool = false // Property to track favorite status

        enum CodingKeys: String, CodingKey {
            case title, subtitle, isbn13, price, image, url
        }
    
    static func == (lhs: Bookdata, rhs: Bookdata) -> Bool {
        return lhs.isbn13 == rhs.isbn13
        
    }
}

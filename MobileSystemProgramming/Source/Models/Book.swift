//
//  Book.swift
//  MobileSystemProgramming
//
//  Created by Illia Starodubtcev on 14.03.2021.
//

import UIKit

struct Books: Codable {
    let books: [BookInfo]
}

struct BookInfo: Codable {
    let title, subtitle, isbn13, price, image: String
    let authors, publisher, pages, year, rating, desc: String?
    
    
    var bookImage: UIImage? {
        guard !image.isEmpty else {
            return UIImage(systemName: "externaldrive.badge.xmark")
        }
        return UIImage(named: image) ?? UIImage(systemName: "externaldrive.badge.xmark")
    }
    
    var getFullInfo: [(field: String, value: String)] {
        return [
            (field: "Title: ", value: title),
            (field: "Subtitle: ", value: subtitle),
            (field: "Authors: ", value: authors ?? "Uknown"),
            (field: "Publisher:", value: publisher ?? "Uknown"),
            (field: "isbn13: ", value: isbn13),
            (field: "Pages: ", value: pages ?? "I don't know digits: "),
            (field: "Year: ", value: year ?? "What's the year"),
            (field: "Rating: ", value: rating ?? "Shit"),
            (field: "desc: ", value: desc ?? "No comments"),
            (field: "Price: ", value: price)
        ]
    }
    init(title: String, subtitle: String, price: String) {
        self.title = title
        self.subtitle = subtitle
        self.price = price
        self.authors = nil
        self.image = ""
        self.publisher = nil
        self.pages = nil
        self.year = nil
        self.rating = nil
        self.desc = nil
        self.isbn13 = String(Int.random(in: 0...Int.max))
    }
}

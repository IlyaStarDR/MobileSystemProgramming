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
    let title, subtitle, isbn13, price: String
    let image: String
    
    var bookImage: UIImage? {
        guard !image.isEmpty else {
            return UIImage(systemName: "externaldrive.badge.xmark")
        }
        return UIImage(named: image) ?? UIImage(systemName: "externaldrive.badge.xmark")
    }
}




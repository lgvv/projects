//
//  Book.swift
//  BookReview
//
//  Created by Hamlit Jason on 2022/01/08.
//

import Foundation

struct Book: Codable {
    let title: String
    private let image: String?
    
    var imageURL: URL? { URL(string: image ?? "" ) }
    
    init(title: String, imageURL: String?) {
        self.title = title
        self.image = imageURL
    }
}

//
//  BookReview.swift
//  BookReview
//
//  Created by Hamlit Jason on 2022/01/09.
//

import Foundation

struct BookReview: Codable {
    let title: String
    let contents: String
    let imageURL: URL?
}

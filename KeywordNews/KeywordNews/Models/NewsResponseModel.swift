//
//  NewsResponseModel.swift
//  KeywordNews
//
//  Created by Hamlit Jason on 2022/02/07.
//

import Foundation

struct NewsResponseModel: Codable {
    var items: [News] = []
}

struct News: Codable {
    let title: String
    let link: String
    let description: String
    let pubDate: String
}

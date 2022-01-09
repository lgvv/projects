//
//  BookSearchRequestModel.swift
//  BookReview
//
//  Created by Hamlit Jason on 2022/01/08.
//

import Foundation

struct BookSearchRequestModel: Codable {
    /// 검색할 책 키워드
    let query: String
}

//
//  MockBookSearchManager.swift
//  BookReviewTests
//
//  Created by Hamlit Jason on 2022/01/21.
//

import XCTest
@testable import BookReview

final class MockBookSearchManager: BookSearchManagerProtocol {
    
    var isRequest = false
    
    func request(from keyword: String, completionHandler: @escaping (([Book]) -> Void)) {
        isRequest = true
    }
}

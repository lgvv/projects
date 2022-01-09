//
//  MockUserDefaultManager.swift
//  BookReviewTests
//
//  Created by Hamlit Jason on 2022/01/09.
//

import XCTest
@testable import BookReview

final class MockUserDefaultsManager: UserDefaultsManagerProtocol {
    
    var isCalledGetReviews = false
    var isCalledSetReview = false
    
    func getReviews() -> [BookReview] {
        isCalledGetReviews = true
        
        return []
    }
    
    func setReview(_ newValue: BookReview) {
        isCalledSetReview = true
    }
    
}

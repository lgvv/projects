//
//  MockUserDefaultManager.swift
//  BookReviewTests
//
//  Created by Hamlit Jason on 2022/01/09.
//

import Foundation
@testable import BookReview

final class MockUserDefaultManager: UserDefaultsManagerProtocol {
    
    var isCalledGetReviews = false
    var isSetReview = false
    
    func getReviews() -> [BookReview] {
        isCalledGetReviews = true
        
        return []
    }
    
    func setReview(_ newValue: BookReview) {
        isSetReview = true
    }
    
}

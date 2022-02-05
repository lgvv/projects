//
//  MockMovieSearchManager.swift
//  MovieReviewTests
//
//  Created by Hamlit Jason on 2022/02/01.
//

import XCTest
@testable import MovieReview

final class MockMovieSearchManager: MovieSearchManagerProtocol {
    
    var isCalledRequest = false
    
    var needToSuccessRequest = false
    
    // 핸들러는 리퀘스트 함수가 성공해야만 다룰 수 있음으로 이렇게 작성한다.
    func request(
        from keyword: String,
        completionHandler: @escaping ([Movie]) -> Void
    ) {
        isCalledRequest = true
        
        if needToSuccessRequest {
            completionHandler([])
        }
    }
    
}

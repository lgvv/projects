//
//  MockNewsSearchManager.swift
//  KeywordNews
//
//  Created by Hamlit Jason on 2022/02/09.
//

import XCTest
@testable import KeywordNews


final class MockNewsSearchManager: NewsSearchManagerProtocol {
    var error: Error? // 실제 리퀘스트 메소드가 에러나 났다는 가정을 하기 위함.
    var isCalledRequest = false
    
    
    func request(from keyword: String, start: Int, display: Int, completionHandler: @escaping ([News]) -> Void) {
        isCalledRequest = true
        
        if error == nil { completionHandler() }
    }
    
    
}

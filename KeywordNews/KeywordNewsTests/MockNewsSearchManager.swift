//
//  MockNewsSearchManager.swift
//  KeywordNews
//
//  Created by Hamlit Jason on 2022/02/09.
//

import Foundation
@testable import KeywordNews

final class MockNewsSearchManager: NewsSearchManagerProtocol {
    var error: Error?
    var isCalledRequest = false

    func request(
        from keyword: String,
        start: Int,
        display: Int,
        completionHandler: @escaping ([News]) -> Void
    ) {
        isCalledRequest = true

        if error == nil {
            completionHandler([])
        }
    }
}

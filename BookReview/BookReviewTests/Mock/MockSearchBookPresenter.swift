//
//  MockSearchBookPresenter.swift
//  BookReviewTests
//
//  Created by Hamlit Jason on 2022/01/21.
//

import XCTest
@testable import BookReview

class MockSearchBookPresenterTest: XCTestCase {
    
}

final class MockSearchBookController: SearchBookProtocol, SearchBookDelegate {
    
    var isSetupViews = false
    var isDismiss = false
    var isReloadView = false
    var isSelectBook = false
    
    func setupViews() {
        isSetupViews = true
    }
    
    func dismiss() {
        isDismiss = true
    }
    
    func reloadView() {
        isReloadView = true
    }
    
    func selectBook(_ book: Book) {
        isSelectBook = true
    }
}

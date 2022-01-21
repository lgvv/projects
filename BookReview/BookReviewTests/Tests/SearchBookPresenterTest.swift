//
//  SearchBookPresenterTest.swift
//  BookReviewTests
//
//  Created by Hamlit Jason on 2022/01/21.


import XCTest
@testable import BookReview

class SearchBookPresenterTest: XCTestCase {
    
    var sut: SearchBookPresenter! // 테스트 대상
    var viewController: MockSearchBookController!
    
    var searchBookDelegate: MockSearchBookController!
    var bookSearchManager: MockBookSearchManager!
    override func setUp() {
        super.setUp()
        
        viewController = MockSearchBookController()
        searchBookDelegate = MockSearchBookController()
        bookSearchManager = MockBookSearchManager()
        
        sut = SearchBookPresenter(
            viewContoller: viewController,
            delegate: searchBookDelegate)
        
    }
    
    override func tearDown() {
        sut = nil
        viewController = nil
        
        super.tearDown()
    }
    
    func test_viewDidLoad가_호출될_때() {
        sut.viewDidLoad()
        
        XCTAssertTrue(viewController
                        .isSetupViews)
    }
}

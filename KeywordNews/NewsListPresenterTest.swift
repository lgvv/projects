//
//  NewsListPresenterTest.swift
//  KeywordNews
//
//  Created by Hamlit Jason on 2022/02/09.
//

import XCTest
@testable import KeywordNews

class NewsListPresenterTest: XCTestCase {
   
    var sut: NewsListPresenter!
    
    var viewController: MockNewsListViewController!
    var newsSearchManager: MockNewsSearchManager!
    
    override func setUp() {
        super.setUp()
        
        viewController = MockNewsListViewController()
        newsSearchManager = MockNewsSearchManager()
        
        sut = NewsListPresenter(viewController: viewController, newsSearchManager: newsSearchManager)
    }
    
    override func tearDown() {
        // tearDown은 setUp의 반대 순서로 하는게 안전
        sut = nil
        
        newsSearchManager = nil
        viewController = nil
    }
    
    func test_viewDidLoad가_불려졌을때() {
        sut.viewDidLoad()
        
        XCTAssertTrue(viewController.isCalledSetupNavigationBar)
        XCTAssertTrue(viewController.isCalledSetupLayout)
    }
}

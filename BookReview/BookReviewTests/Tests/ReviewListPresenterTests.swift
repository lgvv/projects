//
//  BookReviewTests.swift
//  BookReviewTests
//
//  Created by Hamlit Jason on 2022/01/07.
//

import XCTest // 테스트 프레임워크를 import
@testable import BookReview // 테스트 대상의 project를 가져오는 코드

class ReviewListPresenterTests: XCTestCase { // 테스트 케이스를 상속 받고
    
    var sut: ReviewListPresenter! // 테스트 대상은 주로 sut을 사용
    
    //var viewController: MockReviewListViewController!
    var viewController: MockReviewListViewController!
    var userDefaultsManager: MockUserDefaultsManager!
    
    override func setUp() { // 함수가 실행될 때 마다 호출
        super.setUp()
        
        viewController = MockReviewListViewController()
        userDefaultsManager = MockUserDefaultsManager() // 초기화 여기서 해주기!
        
        sut = ReviewListPresenter(
            viewController: viewController,
            userDefaultsManager: userDefaultsManager
            //userDefaultsManager: userDefaultsManager
        )
    }
    
    
    override func tearDown() {
        sut = nil
        viewController = nil
        
        super.tearDown()
    }
    
    func test_viewDidLoad가_호출될_때() {
        sut.viewDidLoad()
        
        XCTAssertTrue(viewController.isCalledSetupNavigationBar)
        XCTAssertTrue(viewController.isCalledSetupViews)
        //XCTAssertFalse(viewController.isCalledSetupNavigationBar)
    }
    
    func test_didTapRightButtonItem이_호출될_때() {
        sut.didTapRightBarButtonItem()
        XCTAssert(viewController.isCalledPresentToReviewWriteViewController)
    }
    
    func test_viewWillAppear가_호출될_때() {
        sut.viewWillAppear()
        XCTAssertTrue(userDefaultsManager.isCalledGetReviews)
        XCTAssertTrue(viewController.isCalledReloadTableView)
    }
    
}

//
//  ReviewWritePresenterTests.swift
//  BookReviewTests
//
//  Created by Hamlit Jason on 2022/01/09.
//

import XCTest
@testable import BookReview

class ReviewWritePresenterTests: XCTestCase {
    var sut: ReviewWritePresenter!
    var viewController: MockReviewWriteViewController!
    var userDefaultManager: MockUserDefaultsManager!
    
    override func setUp() {
        super.setUp()
        
        viewController = MockReviewWriteViewController()
        userDefaultManager  = MockUserDefaultsManager()
        
        sut = ReviewWritePresenter(
            viewController: viewController,
            userDefaultsManager: userDefaultManager
        )
    }
    
    override class func tearDown() {
        sut = nil
        viewController = nil
        userDefaultManager = nil
        
        super.tearDown()
    }
    
    func test_viewDidLoad가_호출될_때() {
        sut.viewDidLoad()
        
        XCTAssertTrue(viewController.isCalledSetUpNavigationBar)
        XCTAssertTrue(viewController.isCalledSetupViews)
    }
}

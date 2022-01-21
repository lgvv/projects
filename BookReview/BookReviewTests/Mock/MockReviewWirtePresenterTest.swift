//
//  MockReviewWirtePresenterTest.swift
//  BookReviewTests
//
//  Created by Hamlit Jason on 2022/01/09.
//

import XCTest
@testable import BookReview

class MockReviewWirtePresenterTest: XCTestCase {
    
}

final class MockReviewWriteViewController: ReviewWriteProtocol {
    
    var isCalledSetUpNavigationBar = false
    var isCalledShowCloseAlertController = false
    var isCalledClose = false
    var isCalledSetupViews = false
    var isCalledPresentToSearchBookViewController = false
    var isCalledupdateViews = false
    
    
    func setUpNavigationBar() {
        isCalledSetUpNavigationBar = true
    }
    
    func showCloseAlertController() {
        isCalledShowCloseAlertController = true
    }
    
    func close() {
        isCalledClose = true
    }
    
    func setupViews() {
        isCalledSetupViews = true
    }
    
    func presentToSearchBookViewController() {
        isCalledPresentToSearchBookViewController = true
    }
    
    func updateViews(title: String, imageURL: URL?) {
        isCalledupdateViews = true
    }
    
}

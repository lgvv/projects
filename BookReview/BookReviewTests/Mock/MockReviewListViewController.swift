//
//  MockReviewListViewController.swift
//  BookReviewTests
//
//  Created by Hamlit Jason on 2022/01/09.
//

import XCTest
@testable import BookReview

final class MockReviewListViewController: ReviewListProtocol {
    
    var isCalledSetupNavigationBar = false
    var isCalledSetupViews = false
    var isCalledPresentToReviewWriteViewController = false
    var isCalledReloadTableView = false

    func setupNavigationBar() {
        isCalledSetupNavigationBar = true
    }

    func setupViews() {
        isCalledSetupViews = true
    }

    func presentToReviewWriteViewController() {
        isCalledPresentToReviewWriteViewController = true
    }

    func reloadTableView() {
        isCalledReloadTableView = true
    }
}

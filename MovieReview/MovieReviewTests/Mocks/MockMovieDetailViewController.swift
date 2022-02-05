//
//  MockMovieDetailViewController.swift
//  MovieReviewTests
//
//  Created by Hamlit Jason on 2022/02/01.
//

import Foundation
@testable import MovieReview

final class MockMovieDetailViewController: MovieDetailProtocol {

    var isCalledSetViews = false
    var isCalledSetRightBarButton = false

    var settedIsLiked = false

    func setViews(with movie: Movie) {
        isCalledSetViews = true
    }

    func setRightbarButton(with isLiked: Bool) {
        settedIsLiked = isLiked

        isCalledSetRightBarButton = true
    }
}

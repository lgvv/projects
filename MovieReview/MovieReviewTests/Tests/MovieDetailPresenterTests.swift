//
//  File.swift
//  MovieDetailPresenterTest
//
//  Created by Hamlit Jason on 2022/02/01.
//

import XCTest
@testable import MovieReview

class MovieDetailPresenterTest: XCTestCase {
    var sut: MovieDetailPresenter!
    
    var viewController: MockMovieDetailViewController!
    var movie: Movie!
    var userDefaultManager: MockUserDefaultsManager!
    
    override func setUp() {
        super.setUp()
        
        viewController = MockMovieDetailViewController()
        movie = Movie(title: "", imageURL: "", userRating: "", actor: "", director: "", pubDate: "")
        userDefaultManager = MockUserDefaultsManager()
        
        sut = MovieDetailPresenter(
            viewController: viewController,
            movie: movie,
            userDefaultsManager: userDefaultManager
        )
    }
    
    override func tearDown() {
        sut = nil
        
        viewController = nil
        movie = nil
        userDefaultManager = nil
        
        super.tearDown()
    }
    
    func test_viewDidLoad() {
        sut.viewDidLoad()
        
        XCTAssertTrue(viewController.isCalledSetViews)
        XCTAssertTrue(viewController.isCalledSetRightBarButton)
    }
    
    func test_didTapRightBarButtonItem이_호출될때_isLiked가_true가되면() {
        movie.isLiked = false
        sut = MovieDetailPresenter(
            viewController: viewController,
            movie: movie,
            userDefaultsManager: userDefaultManager
        )
        
        sut.didTapRightBarButtonItem()
        
        XCTAssertTrue(userDefaultManager.isCalledAddMovie)
        XCTAssertFalse(userDefaultManager.isCalledRemoveMovie)
        
        XCTAssertTrue(viewController.isCalledSetRightBarButton)
    }
    
    func test_didTapRightBarButtonItem이_호출될때_isLiked가_false가되면() {
        movie.isLiked = true
        sut = MovieDetailPresenter(
            viewController: viewController,
            movie: movie,
            userDefaultsManager: userDefaultManager
        )
        
        sut.didTapRightBarButtonItem()
        
        XCTAssertFalse(userDefaultManager.isCalledAddMovie)
        XCTAssertTrue(userDefaultManager.isCalledRemoveMovie)
        
        XCTAssertTrue(viewController.isCalledSetRightBarButton)
    }
}

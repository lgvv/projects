//
//  MovieListPresenterTest.swift
//  MovieReviewTests
//
//  Created by Hamlit Jason on 2022/02/01.
//

import XCTest
@testable import MovieReview

class MovieListPresenterTest: XCTestCase {
    var sut: MovieListPresenter!
    
    var viewController: MockMovieListViewController!
    var userDefaultManager: MockUserDefaultsManager!
    var movieSearchManager: MockMovieSearchManager!
    
    override func setUp() {
        super.setUp()
        
        viewController = MockMovieListViewController()
        userDefaultManager = MockUserDefaultsManager()
        movieSearchManager = MockMovieSearchManager()
        
        sut = MovieListPresenter(
            viewController: viewController,
            movieSearchManager: movieSearchManager,
            userDefaultsManager: userDefaultManager
        )
    }
    
    override func tearDown() {
        sut = nil
        
        viewController = nil
        userDefaultManager = nil
        movieSearchManager = nil
        
        super.tearDown()
    }
    
    // request 메소드가 성공하면 updateTableView가 실행
    func test_serarchBar_textDidChanger가_호출될때_request가_성공하면() {
        movieSearchManager.needToSuccessRequest = true
        sut.searchBar(UISearchBar(), textDidChange: "")
        
        XCTAssertTrue(viewController.isCalledUpdateSearchTableView, "updateSearchTableView가 실행된다.")
    }
    // request 메소드가 실패하면 updateTableView가 실행되지 않음
    func test_serarchBar_textDidChanger가_호출될때_request가_실패하면() {
        movieSearchManager.needToSuccessRequest = false
        sut.searchBar(UISearchBar(), textDidChange: "")
        
        XCTAssertFalse(viewController.isCalledUpdateSearchTableView, "updateSearchTableView가 실행되지 않는다.")
    }
    
    func test_viewDidLoad가_호출되면() {
        sut.viewDidLoad()
        
        XCTAssertTrue(viewController.isCalledSetupNavigationBar)
        XCTAssertTrue(viewController.isCalledSetupSearchBar)
        XCTAssertTrue(viewController.isCalledSetupViews)
    }
    
    func test_viewWillAppear가_호출되면() {
        sut.viewWillAppear()
        
        XCTAssertTrue(userDefaultManager.isCalledGetMovies)
        XCTAssertTrue(viewController.isCalledUpdateCollectionView)
    }
    
    func test_searchBarDidBeginEditing이_호출되면() {
        sut.searchBarTextDidBeginEditing(UISearchBar())
        
        XCTAssertTrue(viewController.isCalledUpdateSearchTableView)
    }
    
    func text_searchBarCancelButton이_호출되면() {
        sut.searchBarCancelButtonClicked(UISearchBar())
        
        XCTAssertTrue(viewController.isCalledUpdateSearchTableView)
    }
}

// Cuckoo 테스트 파일을 자동으로 만들어주는 외부 프레임워크도 존재

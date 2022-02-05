//
//  MovieReviewUITests.swift
//  MovieReviewUITests
//
//  Created by Hamlit Jason on 2022/01/17.
//

import XCTest

// UITest의 경우에는 현업에서는 네트워크에 연결되어있어야 앱이 구동되는점, 또한, 여러번 클릭해서 그 지점으로 가서 사용해야하는 단점으로 인해 Unit테스트만 주로 사용한다.
class MovieReviewUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false // 실패하면 코드 쭉 실행안하고 종료
        
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        
        app = nil
    }
    
    func test_navigationBar의_타이틀이_영화평점으로_설정되어있다() {
        let existNavigationBar = app.navigationBars["영화 평점"].exists
        XCTAssertTrue(existNavigationBar)
    }
    
    func test_SearchBar가_존재한다() {
        // 서치바가 네비게이션의 서치필드에 들어있기 때문에
        let existSearchBar = app.navigationBars["영화 평점"]
            .searchFields["Search"]
            .exists
        XCTAssertTrue(existSearchBar)
    }
    
    func test_SearchBar에_cancel버튼이_존재한다() {
        let navigationBar = app.navigationBars
        navigationBar
            .searchFields["Search"]
            .tap()
        
        let existSearchBarCancelButton = navigationBar
            .buttons["Cancel"]
            .exists
        
        XCTAssertTrue(existSearchBarCancelButton)
    }
    
    func test_녹화버튼을_클릭해서_테스트코드_작성() {
        let app = XCUIApplication()
        let navigationBar = app.navigationBars["영화 평점"]
        let searchSearchField = navigationBar.searchFields["Search"]
        searchSearchField.tap()
        app.tables["Empty list"].swipeUp()
        searchSearchField.swipeDown()
        navigationBar.buttons["Cancel"].tap()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 3).swipeUp()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 2).swipeDown()
    }
    
    // BDD
    enum CellData: String {
        case existsMovie = "셰도우 컨트리"
        case notExistMovie = "007"
    }
    
    func test_영화가_즐겨찾기_되어있으면() {
        let existsCell = app.collectionViews
            .cells
            .containing(.staticText, identifier: CellData.existsMovie.rawValue)
            .element
            .exists
        
        XCTAssertTrue(existsCell, "Title이 표시된 셀이 존재한다")
    }
    
    func test_영화가_즐겨찾기_되어있지_않으면() {
        let existsCell = app.collectionViews
            .cells
            .containing(.staticText, identifier: CellData.notExistMovie.rawValue)
            .element
            .exists
        
        XCTAssertFalse(existsCell, "Title이 표시된 셀이 존재하지 않는다.")
    }
}

//
//  ReviewWritePresenter.swift
//  BookReview
//
//  Created by Hamlit Jason on 2022/01/07.
//

import Foundation

protocol ReviewWriteProtocol {
    func setUpNavigationBar()
    func showCloseAlertController()
    func close()
    func setupViews()
    func presentToSearchBookViewController()
    func updateViews(title: String, imageURL: URL?)
}

final class ReviewWritePresenter {
    private let viewController: ReviewWriteProtocol

    private let userDefaultsManager: UserDefaultsManagerProtocol
    
    var book: Book? // private면 좋으나, test작성에서 optional이면 확인을 못하는데, 그렇다면 아이템을 주기 위해 접근이 필요하다. 그래서 private를 해지함
    
    let contentTextViewPlaceHolderText = "내용을 입력해주세요."
    
    init(
        viewController: ReviewWriteProtocol,
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()
    ) {
        self.viewController = viewController
        self.userDefaultsManager = userDefaultsManager
    }
    
    func viewDidLoad() {
        viewController.setUpNavigationBar()
        viewController.setupViews()
    }
    
    func didTapLeftBarButton() {
        viewController.showCloseAlertController()
    }
    
    func didTapRightBarButton(contentsText: String?) {
        // TODO: UserDefault에 유저가 작성한 도서리뷰 저장하기
        
        guard
            let book = book,
            let contentsText = contentsText,
            contentsText != contentTextViewPlaceHolderText
        else { return }
        
        let bookReview = BookReview(
            title: book.title,
            contents: contentsText,
            imageURL: book.imageURL
        )
        
        userDefaultsManager.setReview(bookReview)
        viewController.close()
    }
    
    func didTapBookTitleButton() {
        viewController.presentToSearchBookViewController()
    }
}

extension ReviewWritePresenter: SearchBookDelegate {
    func selectBook(_ book: Book) {
        self.book = book
        
        viewController.updateViews(title: book.title, imageURL: book.imageURL)
        print("🟠 \(book.title)")
    }
}

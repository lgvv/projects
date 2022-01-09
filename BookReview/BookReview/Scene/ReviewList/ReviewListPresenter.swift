//
//  BookReviewPresenter.swift
//  BookReview
//
//  Created by Hamlit Jason on 2022/01/07.
//

import Foundation
import UIKit
import Kingfisher

protocol ReviewListProtocol {
    func setupNavigationBar()
    func setupViews()
    func presentToReviewWriteViewController()
    func reloadTableView()
}

final class ReviewListPresenter: NSObject { // NSObject 없다면 UITableViewDataSource 상속 시에 그려야 하는 것들이 많다.
    private let viewController: ReviewListProtocol
    private let userDefaultsManager: UserDefaultsManagerProtocol
    
    private var review: [BookReview] = []
    
    init(
        viewController: ReviewListProtocol,
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()
        
    ) {
        self.viewController = viewController
        self.userDefaultsManager = userDefaultsManager
    }
    
    func viewDidLoad() {
        viewController.setupNavigationBar()
        viewController.setupViews()
    }
    
    func viewWillAppear() {
        // TODO: UserDefault 내용 업데이트 하기
        review = userDefaultsManager.getReviews()
        viewController.reloadTableView()
    }
    
    func didTapRightBarButtonItem() {
        viewController.presentToReviewWriteViewController()
    }
}

extension ReviewListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        review.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil) // 서브타이틀이 있는 셀 스타일 사용
        let review = review[indexPath.row]
        cell.textLabel?.text = review.title
        cell.detailTextLabel?.text = review.contents
        //cell.imageView?.kf.setImage(with: review.imageURL) // 이렇게 사용하면 리로드 중에 그릴 수 없어서 한번 더 레이아웃을 조정해야함
        cell.imageView?.kf.setImage(with: review.imageURL, placeholder: .none) { _ in
            cell.setNeedsLayout() // 한번 더 레이아웃 업데이트
        }
        
        cell.selectionStyle = .none
        
        return cell
        
        
    }
}

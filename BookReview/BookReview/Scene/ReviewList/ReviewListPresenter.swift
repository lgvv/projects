//
//  BookReviewPresenter.swift
//  BookReview
//
//  Created by Hamlit Jason on 2022/01/07.
//

import Foundation
import UIKit

protocol ReviewListProtocol {
    func setUpNavigationBar()
    func setupViews()
    func presentToReviewWriteViewController()
    func reloadTableView()
}

final class ReviewListPresenter: NSObject { // NSObject 없다면 UITableViewDataSource 상속 시에 그려야 하는 것들이 많다.
    private let viewController: ReviewListProtocol
    
    init(viewContoller: ReviewListProtocol) {
        self.viewController = viewContoller
    }
    
    func viewDidLoad() {
        viewController.setUpNavigationBar()
        viewController.setupViews()
    }
    
    func viewWillAppear() {
        // TODO: UserDefault 내용 업데이트 하기
        viewController.reloadTableView()
    }
    
    func didTapRightBarButtonItem() {
        viewController.presentToReviewWriteViewController()
    }
}

extension ReviewListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil) // 서브타이틀이 있는 셀 스타일 사용
        cell.textLabel?.text = "\(indexPath)"
        
        return cell
    }
}

//
//  ViewController.swift
//  BookReview
//
//  Created by Hamlit Jason on 2022/01/07.
//

import UIKit

import SnapKit

final class ReviewListViewController: UIViewController {
    
    private lazy var presenter = ReviewListPresenter(viewController: self)
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.dataSource = presenter // presenter에 위임한다.
        
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
        
    }
    
    
}

extension ReviewListViewController: ReviewListProtocol {
    
    func setupNavigationBar() {
        navigationItem.title = "도서 리뷰"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapRightBarButtonItem)
        )
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func setupViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func presentToReviewWriteViewController() {
        let vc = UINavigationController(rootViewController: ReviewWriteViewController()) // 루트뷰를 바꾸는거라서 stack의 결과다 달라진다.
        vc.modalPresentationStyle = .fullScreen
        present(vc,animated: true)
    }
    
    func reloadTableView() {
        tableView.reloadData()
        
        print("새로운 테이블 뷰 리로드")
    }
}


extension ReviewListViewController {
    @objc func didTapRightBarButtonItem() {
        presenter.didTapRightBarButtonItem()
    }
}

/*
 MVP에서는
 dataSource는 presenter에서 처리한다.
 데이터를 구성하여 변경하고 호출해주는 것이기 때문에
 
 MVP에서는 presenter가 무조건 viewController 호출을 담당하고
 viewController은 실행을 담당한다.
 이벤트를 뷰 컨트롤러 내에서 직접 전달(호출)하면 안된다.
 */

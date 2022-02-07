//
//  NewsListViewController.swift
//  KeywordNews
//
//  Created by Hamlit Jason on 2022/02/05.
//

import UIKit
import SnapKit
import Then

class NewsListViewController: UIViewController {

    private lazy var presenter = NewsListPresenter(viewController: self)
    
    private lazy var refreshControl = UIRefreshControl().then {
        $0.addTarget(self, action: #selector(didCalledRefresh), for: .valueChanged)
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.delegate = presenter
        tableView.dataSource = presenter
        
        tableView.register(
            NewsListTableViewCell.self,
            forCellReuseIdentifier: NewsListTableViewCell.identifier
        )

        // 헤더등록 코드가 조금 다르다.
        tableView.register(
            NewsListTableViewHeaderView.self,
            forHeaderFooterViewReuseIdentifier: NewsListTableViewHeaderView.identifier
        )
        
        tableView.refreshControl = refreshControl
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
        NewsSearchManager().request(from: "아이폰", start: 1, display: 20) { newsArray in
            print(newsArray)
        }
    }


}
extension NewsListViewController: NewsListProtocol {
    func setupNavigationBar() {
        navigationItem.title = "NEWS"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
    
    func moveToNewsWebViewController(with news: News) {
        let newWebController = NewWebViewContrller(news: news)
        navigationController?.pushViewController(newWebController, animated: true)
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
}


private extension NewsListViewController {
    @objc func didCalledRefresh() {
        presenter.didCalledRefresh()
    }
}

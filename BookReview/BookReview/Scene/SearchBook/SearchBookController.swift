//
//  SearchViewController.swift
//  BookReview
//
//  Created by Hamlit Jason on 2022/01/07.
//

import Foundation
import UIKit

import SnapKit

final class SearchBookViewContoller: UIViewController {
    
    private lazy var presenter = SearchBookPresenter(
        viewContoller: self,
        delegate: searchBookDelegate
    )
    
    private let searchBookDelegate: SearchBookDelegate
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = presenter
        tableView.dataSource = presenter

        return tableView
    }()
    
    init(searchBookDelegate: SearchBookDelegate) {
        self.searchBookDelegate = searchBookDelegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension SearchBookViewContoller: SearchBookProtocol {
    func setupViews() {
        view.backgroundColor = .systemBackground
        
        let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false // 서치바 활성화되면 서치바 외에 화면 어두워지는거 false처리
        searchController.searchBar.delegate = presenter // delegate를 self가 아닌 presenter로 하는 이유는 데이터를 가지고 그리는 것은 결과적으로 presenter가 하기 때문에 presenter에 위임해야 한다.
        
        navigationItem.searchController = searchController
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func dismiss() {
        navigationItem.searchController?.dismiss(animated: true) // 서치바를 닫고
        dismiss(animated: true) // 화면을 내려서 터치 한번으로 끝내기.
    }
    
    func reloadView() {
        tableView.reloadData()
    }
}

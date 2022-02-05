//
//  ViewController.swift
//  MovieReview
//
//  Created by Hamlit Jason on 2022/01/17.
//

import UIKit
import Then
import SnapKit

class MovieListViewController: UIViewController {

    private lazy var presenter = MovieListPresenter(viewController: self)
    
    private let searchController = UISearchController()
    
    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.delegate = presenter
        collectionView.dataSource = presenter

        collectionView.register(
            MovieListCollectionViewCell.self,
            forCellWithReuseIdentifier: MovieListCollectionViewCell.id
        )
        return collectionView
    }()

    private lazy var searchResultTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = presenter
        tableView.dataSource = presenter
        
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

extension MovieListViewController: MovieListProtocol {
    func setupNavigationBar() {
        navigationItem.title = "영화 평점"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }

    func setupSearchBar() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = presenter

        navigationItem.searchController = searchController
    }

    func setupViews() {
        [collectionView, searchResultTableView].forEach {
            view.addSubview($0)
        }

        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        searchResultTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        searchResultTableView.isHidden = true
    }

    func updateSearchTableView(isHidden: Bool) {
        print("updateSearchTableView \(isHidden) ")
        searchResultTableView.isHidden = isHidden
        searchResultTableView.reloadData()
    }
    
    func pushToMovieViewController(with movie: Movie) {
        let movieDetailViewController = MovieDetailViewController(movie: movie)
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
    
    func updateCollectionView() {
        collectionView.reloadData()
    }
}

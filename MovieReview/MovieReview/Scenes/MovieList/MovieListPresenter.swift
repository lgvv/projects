//
//  MovieListPresenter.swift
//  MovieReview
//
//  Created by Hamlit Jason on 2022/01/20.
//

import UIKit

protocol MovieListProtocol: AnyObject {
    func setupNavigationBar()
    func setupSearchBar()
    func setupViews()
    func updateSearchTableView(isHidden: Bool)
    func pushToMovieViewController(with movie: Movie)
    func updateCollectionView()
}

// MSObject는 서치바의 딜리게이트를 따르기 위해서 필요함.
final class MovieListPresenter: NSObject {
    // weak var의 경우에는 화면 사라짐이 빈번한 경우 메모리 낭비를 막기 위해 조금 더 안전하게 사용하는 방법
    private weak var viewController: MovieListProtocol?

    private let userDefaultsManager: UserDefaultsManagerProtocol
    private let movieSearchManager: MovieSearchManagerProtocol

    private var likedMovie: [Movie] = []

    private lazy var currentMovieSearchResult: [Movie] = []

    init(
        viewController: MovieListProtocol,
        movieSearchManager: MovieSearchManagerProtocol = MovieSearchManager(),
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()
    ) {
        self.viewController = viewController
        self.movieSearchManager = movieSearchManager
        self.userDefaultsManager = userDefaultsManager
    }

    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupSearchBar()
        viewController?.setupViews()
    }
    
    func viewWillAppear() {
        likedMovie = userDefaultsManager.getMovies()
        viewController?.updateCollectionView()
    }
}

extension MovieListPresenter: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewController?.updateSearchTableView(isHidden: false)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        currentMovieSearchResult = []
        viewController?.updateSearchTableView(isHidden: true)

    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        movieSearchManager.request(from: searchText, completionHandler: { [weak self] movies in
            print(movies)
            self?.currentMovieSearchResult = movies
            self?.viewController?.updateSearchTableView(isHidden: false)
        })
    }
}

extension MovieListPresenter: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
            let spacing: CGFloat = 16
            let width: CGFloat = (collectionView.frame.width - spacing * 3) / 2

            return CGSize(width: width, height: 210.0)
        }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int) -> UIEdgeInsets {
            let inset: CGFloat = 16.0
            return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = likedMovie[indexPath.item]
        viewController?.pushToMovieViewController(with: movie)
    }
}

extension MovieListPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return likedMovie.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieListCollectionViewCell.id,
            for: indexPath
        ) as? MovieListCollectionViewCell

        let movie = likedMovie[indexPath.item]
        cell?.update(movie)

        return cell ?? UICollectionViewCell()
    }
}

extension MovieListPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = currentMovieSearchResult[indexPath.row]
        viewController?.pushToMovieViewController(with: movie)
    }
}

extension MovieListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tableView_numberOfRowsInSection")
        return currentMovieSearchResult.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = currentMovieSearchResult[indexPath.row].title

        return cell
    }
}

// weak var와 unowned let 면접에 단골이니 꼭 알아보기

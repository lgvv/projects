//
//  SearchBookPresenter.swift
//  BookReview
//
//  Created by Hamlit Jason on 2022/01/07.
//

import Foundation
import UIKit

protocol SearchBookProtocol {
    func setupViews()
    func dismiss()
    func reloadView()
}

protocol SearchBookDelegate {
    func selectBook(_ book: Book)
}

final class SearchBookPresenter: NSObject {
    private let viewContoller: SearchBookProtocol
    private let bookSearchManager = BookSearchManager()
    private let delegate: SearchBookDelegate
    
    private var books: [Book] = []
    
    init(viewContoller: SearchBookViewContoller,
         delegate: SearchBookDelegate
    ) {
        self.viewContoller = viewContoller
        self.delegate = delegate
    }
    
    func viewDidLoad() {
        viewContoller.setupViews()
    }
}

extension SearchBookPresenter: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        
        bookSearchManager.request(from: searchText) { [weak self] newBooks in
            self?.books = newBooks
            self?.viewContoller.reloadView()
        }
    }
}

extension SearchBookPresenter: UITableViewDelegate {
    
}

extension SearchBookPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = books[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBook = books[indexPath.row]
        delegate.selectBook(selectedBook)
        
        viewContoller.dismiss() 
    }
}

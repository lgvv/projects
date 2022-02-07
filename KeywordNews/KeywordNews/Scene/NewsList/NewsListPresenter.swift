//
//  NewsListPresenter.swift
//  KeywordNews
//
//  Created by Hamlit Jason on 2022/02/05.
//

import Foundation
import UIKit

protocol NewsListProtocol: AnyObject {
    func setupNavigationBar()
    func setupLayout()
    func endRefreshing()
    func moveToNewsWebViewController(with news: News)
    func reloadTableView()
}

final class NewsListPresenter: NSObject {
    private weak var viewController: NewsListProtocol?
    private let newsSearchManager: NewsSearchManagerProtocol
    
    private var newsList: [News] = []
    private var currentKeyword = ""
    /// 지금까지  request된, 가지고 있는 보여주고 있는 페이지가 어디인지
    private var currentPage: Int = 0
    /// 한 페이지에 최대 몇 개까지 보여줄 것인지
    private let display: Int = 20
    
    private let tags: [String] = ["IT", "아이폰", "개발", "개발자", "판교", "게임", "앱개발", "강남", "스타트업"]
    
    init(
        viewController: NewsListProtocol,
        newsSearchManager: NewsSearchManagerProtocol = NewsSearchManager()
    ) {
        self.viewController = viewController
        self.newsSearchManager = newsSearchManager
    }
    
    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupLayout()
    }
    
    func didCalledRefresh() {
        requestNewsList(isNeededToReset: true)

    }
}

extension NewsListPresenter: NewsListTableViewHeaderViewDelegate {
    func didSelectTag(_ selectedIndex: Int) {
        currentKeyword = tags[selectedIndex]
        requestNewsList(isNeededToReset: true)
    }
    
    
}

extension NewsListPresenter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = newsList[indexPath.row]
        viewController?.moveToNewsWebViewController(with: news)
    }

    // 안보이는 셀이 보여지려고 하면 이 메소드가 호출된다. -> 페이지 네이션을 위해 (무한 스크롤)
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        let currentRow = indexPath.row // 현재 보여지고 있는 Row

        // 끝에 닿기 3개 전에 이 작업 작업 실행하기 위한 guard 문
        guard (currentRow % 20) == display - 3 && (currentRow / display) == (currentPage - 1) else { return }

        requestNewsList(isNeededToReset: false)
    }
    
}

extension NewsListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsListTableViewCell.identifier,
            for: indexPath
        ) as? NewsListTableViewCell else { return UITableViewCell() }
        
        let news = newsList[indexPath.row]
        cell.setup(news: news)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: NewsListTableViewHeaderView.identifier
        ) as? NewsListTableViewHeaderView
            
        header?.setup(tags: tags, delegate: self)
        
        return header
    }
}

private extension NewsListPresenter {
    // 페이지 네이션을 통하여 구현되었음.
    func requestNewsList(isNeededToReset: Bool) {
        // reset을 하는 이유는 스크롤을 무한히 내렸다가 위에서 refreshControl을 할 경우 스크롤 바퀴가 다시 커지게 끔 조정하기 위함. 즉 위에서 리프레시를 실시할 경우 셀이 20개로 맞춰진다.
        if isNeededToReset {
            currentPage = 0
            newsList = []
        }
        
        newsSearchManager.request(
            from: currentKeyword,
            start: (currentPage * display) + 1, // 네이버 API는 시작점이 1부터라서
            display: 20) { [weak self] newValue in
                self?.newsList += newValue // 페이지 네이션을 위한 코드(대입이 아니라 더하기)
                self?.currentPage += 1
                self?.viewController?.reloadTableView()
                self?.viewController?.endRefreshing()
            }
    }
}

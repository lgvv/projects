//
//  NewWebView.swift
//  KeywordNews
//
//  Created by Hamlit Jason on 2022/02/07.
//

import Foundation
import WebKit
import UIKit

import SnapKit

final class NewWebViewContrller: UIViewController {
    private let news: News
    private let webView = WKWebView()
    
    private var rightBarButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "link"),
        style: .plain,
        target: self,
        action: #selector(didTapRightBarButtonItem))
    
    init(news: News) {
        self.news = news
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupNavigationbBar()
        setupWebView()
    }
}

private extension NewWebViewContrller {
    func setupNavigationbBar() {
        navigationItem.title = news.title.htmlToString
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func setupWebView() {
        guard let linkURL = URL(string: news.link) else {
            // 링크가 없다면 자동으로 팝해주면 UX적으로 더 좋은듯
            navigationController?.popViewController(animated: true)
            return
        }
        
        view = webView
        
        let urlRequest = URLRequest(url: linkURL)
        webView.load(urlRequest)
    }
    
    @objc func didTapRightBarButtonItem() {
        UIPasteboard.general.string = news.link // 클립 보드에 복사하는 메소드
    }
}

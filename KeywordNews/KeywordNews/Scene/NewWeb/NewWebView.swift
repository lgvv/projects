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
    
    private let webView = WKWebView()
    
    private var rightBarButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "link"),
        style: .plain,
        target: self,
        action: #selector(didTapRightBarButtonItem))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupNavigationbBar()
        setupWebView()
    }
}

private extension NewWebViewContrller {
    func setupNavigationbBar() {
        navigationItem.title = "기사 제목"
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func setupWebView() {
        guard let linkURL = URL(string: "https://www.naver.com") else {
            // 링크가 없다면 자동으로 팝해주면 UX적으로 더 좋은듯
            navigationController?.popViewController(animated: true)
            return
        }
        
        view = webView
        
        let urlRequest = URLRequest(url: linkURL)
        webView.load(urlRequest)
    }
    
    @objc func didTapRightBarButtonItem() {
        UIPasteboard.general.string = "뉴스 링크" // 클립 보드에 복사하는 메소드
    }
}

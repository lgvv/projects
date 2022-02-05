//
//  MovieDetailViewController.swift
//  MovieReview
//
//  Created by Hamlit Jason on 2022/01/30.
//

import Foundation
import UIKit
import Then
import SnapKit
import Kingfisher

class MovieDetailViewController: UIViewController {
    
    private var presenter: MovieDetailPresenter!
    
    private lazy var rightBarButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "star"),
        style: .plain,
        target: self, // self는 본인이 초기화될 때 본인을 못넣기 때문에 lazy를 사용해야 한다.
        action: #selector(didTapRightBarButtonItem)
    )
    
    private lazy var imageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .secondarySystemBackground
    }
    
    init(movie: Movie) {
        super.init(nibName: nil, bundle: nil)
        
        presenter = MovieDetailPresenter(
            viewController: self,
            movie: movie
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
}

extension MovieDetailViewController: MovieDetailProtocol {
    
    func setViews(with movie: Movie) {
        view.backgroundColor = .systemBackground
        
        navigationItem.title = movie.title
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        let userRatingContentsStackView = MovieContentStackView(title: "평점", contents: movie.userRating)
        let actorContentsStackView = MovieContentStackView(title: "배우", contents: movie.actor)
        let directorContentsStackView = MovieContentStackView(title: "감독", contents: movie.director)
        let pubDateContentsStackView = MovieContentStackView(title: "제작년도", contents: movie.pubDate)
        
        let contentsStackView = UIStackView()
        contentsStackView.axis = .vertical
        contentsStackView.spacing = 8.0
        
        [
            userRatingContentsStackView,
            actorContentsStackView,
            directorContentsStackView,
            pubDateContentsStackView
        ].forEach {
            contentsStackView.addArrangedSubview($0)
        }
        
        
        [imageView, contentsStackView].forEach { view.addSubview($0) }
        
        let inset: CGFloat = 16.0
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).inset(inset)
            $0.leading.equalToSuperview().inset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(imageView.snp.width)
        }
        
        contentsStackView.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.leading)
            $0.trailing.equalTo(imageView.snp.trailing)
            $0.top.equalTo(imageView.snp.bottom).offset(inset)
        }
        
        // 이미지 URL이 존재할때만 실행
        if let imageURL = movie.imageURL {
            imageView.kf.setImage(with: movie.imageURL)
        }
    }
    
    func setRightbarButton(with isLiked: Bool) {
        let imageName = isLiked ? "star.fill" : "star"
        rightBarButtonItem.image = UIImage(systemName: imageName)
    }
}

private extension MovieDetailViewController {
    @objc func didTapRightBarButtonItem() {
        presenter.didTapRightBarButtonItem()
    }
}

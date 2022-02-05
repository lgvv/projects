//
//  MovieListCollectionViewCell.swift
//  MovieReview
//
//  Created by Hamlit Jason on 2022/01/21.
//

import UIKit
import SnapKit
import Then
import Kingfisher

final class MovieListCollectionViewCell: UICollectionViewCell {
    static let id = "MovieListCollectionView"

    private lazy var imageView = UIImageView().then {
        $0.clipsToBounds = true // 이미지가 넘치지 않게끔
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .secondarySystemBackground
    }

    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14.0, weight: .semibold)
    }

    private lazy var userRatingLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13.0, weight: .medium)
    }

    func update(_ movie: Movie) {
        setupView()
        setupLayout()
    
        imageView.kf.setImage(with: movie.imageURL)
        titleLabel.text = movie.title
        userRatingLabel.text = "⭐️ \(movie.userRating)"

    }

}

private extension MovieListCollectionViewCell {
    func setupView() {
        layer.cornerRadius = 12.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1 // 투명도
        layer.shadowRadius = 8.0
        
        backgroundColor = .systemBackground // 이게 설정되어야 그림자 잘보임
        
    }
    
    func setupLayout() {
        [imageView, titleLabel, userRatingLabel].forEach{ self.addSubview($0) }
        
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.top.equalToSuperview().inset(16.0)
            $0.height.equalTo(imageView.snp.width)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8.0)
            $0.leading.equalTo(imageView.snp.leading)
            $0.trailing.equalTo(imageView.snp.trailing)
        }
        
        userRatingLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.leading)
            $0.trailing.equalTo(imageView.snp.trailing)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4.0)
            $0.bottom.equalToSuperview().inset(8.0)
        }
    }
}

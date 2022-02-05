//
//  MovieContentStackView.swift
//  MovieReview
//
//  Created by Hamlit Jason on 2022/01/30.
//

import Foundation
import SnapKit
import Then
import UIKit
import SwiftUI

final class MovieContentStackView: UIStackView {
    
    private let title: String
    private let contents: String
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14.0, weight: .semibold)
        $0.text = title
    }
    
    private lazy var contentsLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14.0, weight: .medium)
        $0.text = contents
    }
    
    init(title: String, contents: String) {
        self.title = title
        self.contents = contents
        
        super.init(frame: .zero)
        
        // super.init 다음에 이 코드를 넣어야 함.
        axis = .horizontal
        [titleLabel, contentsLabel].forEach {
            addArrangedSubview($0) // self 생략가능
        }
        
        // 스택뷰라서 타이틀만 잡으면 컨텐츠는 알아서 결정이 된다.
        titleLabel.snp.makeConstraints {
            $0.width.equalTo(80.0)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  NewsListTableViewCell.swift
//  KeywordNews
//
//  Created by Hamlit Jason on 2022/02/05.
//

import Foundation
import SnapKit
import Then
import UIKit

final class NewsListTableViewCell: UITableViewCell {
    static let identifier = "NewsListTableViewCell"
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15.0, weight: .semibold)
    }
    
    private lazy var descriptionLabel  = UILabel().then {
        $0.font = .systemFont(ofSize: 14.0, weight: .medium)
    }
    
    private lazy var dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12.0, weight: .medium)
        $0.textColor = .secondaryLabel
    }
    
    func setup() {
        setupLayout()
        
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        
        titleLabel.text = "기사제목"
        descriptionLabel.text = "기사내용"
        dateLabel.text = "20220205"
    }
}
private extension NewsListTableViewCell {
    // 셀 크기를 height으로 지정해주지 않아도 자동으로 잡힘!
    func setupLayout() {
        [titleLabel, descriptionLabel, dateLabel]
            .forEach { addSubview($0) }

        let superViewInset: CGFloat = 16.0

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(superViewInset)
            $0.trailing.equalToSuperview().inset(48.0)
            $0.top.equalToSuperview().inset(superViewInset)
        }

        let verticalSpacing: CGFloat = 4.0

        descriptionLabel.snp.makeConstraints{
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalTo(titleLabel.snp.trailing)
            $0.top.equalTo(titleLabel.snp.bottom).offset(verticalSpacing)
        }

        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalTo(titleLabel.snp.trailing)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(verticalSpacing)
            $0.bottom.equalToSuperview().inset(superViewInset)
        }
    }
}

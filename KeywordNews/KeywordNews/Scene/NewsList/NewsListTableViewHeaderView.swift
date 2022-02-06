//
//  NewsListTableViewHeaderView.swift
//  KeywordNews
//
//  Created by Hamlit Jason on 2022/02/05.
//

import UIKit

import SnapKit
import TTGTags

final class NewsListTableViewHeaderView: UITableViewHeaderFooterView {
    static let identifier = "NewsListTableViewHeaderView"

    private lazy var tagCollectionView = TTGTextTagCollectionView()
    
    private var tags: [String] = ["IT", "아이폰", "개발", "개발자", "판교", "게임", "앱개발", "강남", "스타트업"]
    
    func setup() {
        contentView.backgroundColor = .systemBackground
        
        setupTagCollectionViewLayout()
        setupTagCollectionView()
    }
}


extension NewsListTableViewHeaderView: TTGTextTagCollectionViewDelegate {
    func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, didTap tag: TTGTextTag!, at index: UInt) {
        guard tag.selected else { return } // 태그가 셀렉 되었을 때만 불려지게끔 필터링 해주기 -> 태그가 셀렉되지 않은 상태로 조건이 변경될 때도 불려지기 때문에
        
        print(tags[Int(index)])
    }
}

private extension NewsListTableViewHeaderView {
    func setupTagCollectionViewLayout() {
        addSubview(tagCollectionView)
        
        tagCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setupTagCollectionView() {
        tagCollectionView.delegate = self
        tagCollectionView.numberOfLines = 1
        tagCollectionView.scrollDirection = .horizontal
        tagCollectionView.showsVerticalScrollIndicator = false
        tagCollectionView.selectionLimit = 1
        
        let insetValue: CGFloat = 16.0
        tagCollectionView.contentInset = UIEdgeInsets(
            top: insetValue,
            left: insetValue,
            bottom: insetValue,
            right: insetValue
        )
        
        let cornerRadiusValue: CGFloat = 12.0
        let shadowOpacity: CGFloat = 0.0
        let extraSpace = CGSize(width: 20.0, height: 12.0)
        let color = UIColor.systemOrange
        
        let style = TTGTextTagStyle()
        style.backgroundColor = color
        style.cornerRadius = cornerRadiusValue
        style.borderWidth = 0.0
        style.shadowOpacity = shadowOpacity
        style.extraSpace = extraSpace

        let selectedStyle = TTGTextTagStyle()
        selectedStyle.backgroundColor = .white
        selectedStyle.cornerRadius = cornerRadiusValue
        selectedStyle.shadowOpacity = shadowOpacity
        selectedStyle.extraSpace = extraSpace
        selectedStyle.borderColor = color
        
        tags.forEach { tag in
            let font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
            let tagContents = TTGTextTagStringContent(
                text: tag,
                textFont: font,
                textColor: .white
            )
            let selectedTagContents = TTGTextTagStringContent(
                text: tag,
                textFont: font,
                textColor: color
            )

            let tag = TTGTextTag(
                content: tagContents,
                style: style,
                selectedContent: selectedTagContents,
                selectedStyle: selectedStyle
            )

            tagCollectionView.addTag(tag)
        }
    }
}

//
//  NewRequestModel.swift
//  KeywordNews
//
//  Created by Hamlit Jason on 2022/02/07.
//

import Foundation

struct NewsRequestModel: Codable {
    /// 시작 인덱스. 1 ~ 1000
    let start: Int
    /// 검색 결과 출력 건수, 10 ~ 1000
    let display: Int
    /// 검색어
    let query: String
}

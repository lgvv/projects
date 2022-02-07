//
//  String+.swift
//  KeywordNews
//
//  Created by Hamlit Jason on 2022/02/08.
//

import Foundation

extension String {
    // html을 string으로 변환해주는 코드
    var htmlToString: String {
        guard let data = self.data(using: .utf8) else { return "" }
        
        do {
            return try NSAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                
                ],
                documentAttributes: nil
            ).string
        } catch {
            return ""
        }
    }
}

//
//  BookSearchManager.swift
//  BookReview
//
//  Created by Hamlit Jason on 2022/01/08.
//

import Foundation

import Alamofire

struct BookSearchManager {
    func request(from keyword: String, completionHandler: @escaping (([Book]) -> Void)) {
        guard let url = URL(string: "https://openapi.naver.com/v1/search/book.json") else { return }

        let parameters = BookSearchRequestModel(query: keyword)
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "{Your Api Key}",
            "X-Naver-Client-Secret": "{Your Api Key}"
        ]

        AF
            .request(url, method: .get, parameters: parameters, headers: headers)
            .responseDecodable(of: BookSearchResponseModel.self) { response in // decodable로 받은 데이터를 파싱. 타입은 of안에 있는 모델로
                switch response.result {
                case .success(let result):
                    completionHandler(result.items) // complectionHandler가 있어야 받는 쪽에서 바로 사용할 수 있도록 하기 위함 -> 테이블 뷰를 바로 그릴 수 있게끔
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
}

//
//  MovieSearchManager.swift
//  MovieReview
//
//  Created by Hamlit Jason on 2022/01/20.
//

import Foundation
import UIKit
import Alamofire

protocol MovieSearchManagerProtocol {
    func request(from keyword: String, completionHandler: @escaping ([Movie]) -> Void)
}

struct MovieSearchManager: MovieSearchManagerProtocol {
    func request(from keyword: String, completionHandler: @escaping ([Movie]) -> Void) {
        guard let url = URL(string:"https://openapi.naver.com/v1/search/movie.json") else {
            return
        }
        
        let parameters = MovieSearchRequestModel(query: keyword)
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": "{YOUR API KEY}",
            "X-Naver-Client-Secret": "{YOUR API KEY}"
        ]
        
        AF.request(
            url,
            method: .get,
            parameters: parameters,
            headers: header
        )
            .responseDecodable(of: MovieSearchResponseModel.self) { response in
                switch response.result {
                case .success(let result):
                    completionHandler(result.items)
                case .failure(let error):
                    print(error)
                }
            }
            .resume()
    }
}

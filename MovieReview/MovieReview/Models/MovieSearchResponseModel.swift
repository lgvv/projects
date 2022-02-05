//
//  MovieSearchResponseModel.swift
//  MovieReview
//
//  Created by Hamlit Jason on 2022/01/20.
//

import Foundation

struct MovieSearchResponseModel: Decodable {
    var items: [Movie] = []
}

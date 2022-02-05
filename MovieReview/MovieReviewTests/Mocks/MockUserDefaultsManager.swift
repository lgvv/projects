//
//  MockUserDefaultsManager.swift
//  MovieReviewTests
//
//  Created by Hamlit Jason on 2022/02/01.
//

import XCTest
@testable import MovieReview

final class MockUserDefaultsManager: UserDefaultsManagerProtocol {
    
    var isCalledGetMovies = false
    var isCalledAddMovie = false
    var isCalledRemoveMovie = false
    
    func getMovies() -> [Movie] {
        isCalledGetMovies = true
        return []
    }
    
    func addMovie(_ newValue: Movie) {
        isCalledAddMovie = true
    }
    
    func removeMovie(_ value: Movie) {
        isCalledRemoveMovie = true
    }
}

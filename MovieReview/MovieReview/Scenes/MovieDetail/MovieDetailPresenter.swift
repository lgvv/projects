//
//  MoviewDetailPresenter.swift
//  MovieReview
//
//  Created by Hamlit Jason on 2022/01/30.
//

import Foundation

protocol MovieDetailProtocol: AnyObject {
    func setViews(with movie: Movie)
    func setRightbarButton(with isLiked: Bool)
}

final class MovieDetailPresenter {
    
    private weak var viewCotnroller: MovieDetailProtocol?

    private let userDefaultsManager: UserDefaultsManagerProtocol
    
    private var movie: Movie
    
    init(
        viewController: MovieDetailProtocol,
        movie: Movie,
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()
    ) {
        self.viewCotnroller = viewController
        self.movie = movie
        self.userDefaultsManager = userDefaultsManager
    }
    
    func viewDidLoad() {
        viewCotnroller?.setViews(with: movie)
        viewCotnroller?.setRightbarButton(with: movie.isLiked)
    }
    
    func didTapRightBarButtonItem() {
        
        movie.isLiked.toggle() // Boolean 타입에서 값을 반대로 바꿔줌
        if movie.isLiked {
            userDefaultsManager.addMovie(movie)
        } else {
            userDefaultsManager.removeMovie(movie)
        }
        
        viewCotnroller?.setRightbarButton(with: movie.isLiked)
    }
}

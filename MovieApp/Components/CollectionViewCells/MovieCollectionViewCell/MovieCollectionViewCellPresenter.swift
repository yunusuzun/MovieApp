//
//  MovieCollectionViewCellPresenter.swift
//  MovieApp
//
//  Created by Yunus Uzun on 8.09.2023.
//

import Foundation

protocol MovieCollectionViewCellPresenterProtocol {
    func load()
}

final class MovieCollectionViewCellPresenter: MovieCollectionViewCellPresenterProtocol {
    private weak var view: MovieCollectionViewCellProtocol?
    private let movie: MoviePresentation

    init(view: MovieCollectionViewCellProtocol?, movie: MoviePresentation) {
        self.view = view
        self.movie = movie
    }
    
    func load() {
        view?.prepareCell()
        view?.preparePosterImage(with: movie.poster!)
        view?.setTitle(movie.title!)
    }
}

//
//  MovieTableViewCellPresenter.swift
//  MovieApp
//
//  Created by Yunus Uzun on 7.09.2023.
//

protocol MovieTableViewCellPresenterProtocol {
    func load()
}

final class MovieTableViewCellPresenter: MovieTableViewCellPresenterProtocol {
    private weak var view: MovieTableViewCellProtocol?
    private let movie: MoviePresentation

    init(view: MovieTableViewCellProtocol?, movie: MoviePresentation) {
        self.view = view
        self.movie = movie
    }
    
    func load() {
        if let poster = movie.poster, let year = movie.year, let type = movie.type?.rawValue.capitalizeFirstLetter, let title = movie.title {
            view?.prepareCell()
            view?.preparePosterImage(with: poster)
            view?.setYear(year)
            view?.setType(type)
            view?.setTitle(title)
        }
    }
}

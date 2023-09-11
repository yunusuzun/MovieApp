//
//  MovieDetailPresenter.swift
//  MovieApp
//
//  Created by Yunus Uzun on 8.09.2023.
//

import Foundation

protocol MovieDetailPresenterProtocol: AnyObject {
    func load()
    func viewWillAppear()
}

final class MovieDetailPresenter {
    private weak var view: MovieDetailViewProtocol?
    private let interactor: MovieDetailInteractorProtocol
    private var id: String
    
    init(id: String, interactor: MovieDetailInteractorProtocol, view: MovieDetailViewProtocol?) {
        self.view = view
        self.interactor = interactor
        self.id = id
        
        interactor.delegate = self
    }
}

extension MovieDetailPresenter: MovieDetailPresenterProtocol {
    func viewWillAppear() {
        view?.handle(.prepareNavigationBar)
    }
    
    func load() {
        view?.handle(.showLoading(true))
        self.view?.handle(.prepareView)
        self.interactor.load(query: ["apikey": APIConstants.apiKey, "i": self.id])
    }
}

extension MovieDetailPresenter: MovieDetailInteractorDelegate {
    func handleOutput(_ output: MovieDetailInteractorOutput) {
        switch output {
        case .didFetchMovie(let movie):
            let moviePresentation = MovieDetailPresentation(movie: movie)
            view?.handle(.preparePoster(moviePresentation.poster ?? .empty))
            view?.handle(.setTitle(moviePresentation.title ?? .empty))
            view?.handle(.setCountry(moviePresentation.country ?? .empty))
            view?.handle(.setYear(moviePresentation.year ?? .empty))
            view?.handle(.setLenght(moviePresentation.lenght ?? .empty))
            view?.handle(.setDescription(moviePresentation.description ?? .empty))
        case .didFail(let error):
            view?.showAlert(title: "Oppss!", message: error.localizedDescription)
        }
        
        view?.handle(.showLoading(false))
    }
}

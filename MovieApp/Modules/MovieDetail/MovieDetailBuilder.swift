//
//  MovieDetailBuilder.swift
//  MovieApp
//
//  Created by Yunus Uzun on 8.09.2023.
//

struct MovieDetailBuilder {
    static func make(id: String) -> MovieDetailViewController {
        let view = MovieDetailViewController()
        let interactor = MovieDetailInteractor()
        let presenter = MovieDetailPresenter(id: id, interactor: interactor, view: view)
        view.presenter = presenter
        return view
    }
}


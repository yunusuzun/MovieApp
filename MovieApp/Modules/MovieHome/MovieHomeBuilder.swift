//
//  MovieHomeBuilder.swift
//  MovieApp
//
//  Created by Yunus Uzun on 7.09.2023.
//

struct MovieHomeBuilder {
    static func make() -> MovieHomeViewController {
        let view = MovieHomeViewController()
        let interactor = MovieHomeInteractor()
        let router = MovieHomeRouter(view: view)
        let presenter = MovieHomePresenter(interactor: interactor, router: router, view: view)
        view.presenter = presenter
        return view
    }
}

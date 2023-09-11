//
//  MovieHomeRouter.swift
//  MovieApp
//
//  Created by Yunus Uzun on 7.09.2023.
//

import UIKit

enum MovieHomeRoute {
    case detail(id: String)
}

protocol MovieHomeRouterProtocol: AnyObject {
    func navigate(to route: MovieHomeRoute)
}

final class MovieHomeRouter: MovieHomeRouterProtocol {
    unowned let view: MovieHomeViewController
    
    init(view: MovieHomeViewController) {
        self.view = view
    }
    
    func navigate(to route: MovieHomeRoute) {
        switch route {
        case .detail(let id):
            let detailView = MovieDetailBuilder.make(id: id)
            view.navigationController?.pushViewController(detailView, animated: true)
        }
    }
}

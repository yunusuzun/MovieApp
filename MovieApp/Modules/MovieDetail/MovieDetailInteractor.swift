//
//  MovieDetailInteractor.swift
//  MovieApp
//
//  Created by Yunus Uzun on 8.09.2023.
//

import Foundation

enum MovieDetailInteractorOutput {
    case didFetchMovie(MovieDetailEntity)
    case didFail(Error)
}

protocol MovieDetailInteractorDelegate: AnyObject {
    func handleOutput(_ output: MovieDetailInteractorOutput)
}

protocol MovieDetailInteractorProtocol: AnyObject {
    var delegate: MovieDetailInteractorDelegate? { get set }
    
    func load(query: [String: Any])
}

final class MovieDetailInteractor: MovieDetailInteractorProtocol {
    let provider = NetworkProvider<MovieEndpoint>()
    
    weak var delegate: MovieDetailInteractorDelegate?
    
    func load(query: [String: Any]) {
        provider.request(.getMovie(query: query)) { [weak self] (result: Result<MovieDetailEntity, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let movie):
                    self?.notify(.didFetchMovie(movie))
                case .failure(let error):
                    self?.notify(.didFail(error))
                }
            }
        }
    }
}

private extension MovieDetailInteractor {
    func notify(_ output: MovieDetailInteractorOutput) {
        delegate?.handleOutput(output)
    }
}



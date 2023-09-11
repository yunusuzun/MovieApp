//
//  MovieHomeInteractor.swift
//  MovieApp
//
//  Created by Yunus Uzun on 7.09.2023.
//

import Foundation

protocol MovieHomeInteractorProtocol: AnyObject {
    func load(query: [String: Any], completion: @escaping (Result<MovieEntity, Error>) -> Void)
}

final class MovieHomeInteractor: MovieHomeInteractorProtocol {
    let provider = NetworkProvider<MovieEndpoint>()
    
    func load(query: [String: Any], completion: @escaping (Result<MovieEntity, Error>) -> Void) {
        provider.request(.getMovie(query: query)) { (result: Result<MovieEntity, Error>) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}

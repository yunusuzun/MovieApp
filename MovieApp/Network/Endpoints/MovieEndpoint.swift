//
//  MovieEndpoint.swift
//  MovieApp
//
//  Created by Yunus Uzun on 7.09.2023.
//

import Foundation

enum MovieEndpoint {
    case getMovie(query: [String: Any])
    case getMovieDetail(query: [String: Any])
}

extension MovieEndpoint: Endpoint {
    var baseURL: URL {
        URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getMovie, .getMovieDetail:
            return "/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMovie, .getMovieDetail:
            return .get
        }
    }
    
    var headers: [String: String]? {
        [Header.Key.contentType: Header.Value.json]
    }
    
    var task: Task {
        switch self {
        case .getMovie(let query):
            return .requestParameters(query: query)
        case .getMovieDetail(query: let query):
            return .requestParameters(query: query)
        }
    }
}

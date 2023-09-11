//
//  URL+Extension.swift
//  MovieApp
//
//  Created by Yunus Uzun on 7.09.2023.
//

import Foundation

extension URL {
    func appending(queryParameters parameters: [String: Any]) -> URL {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else { return self }
        
        urlComponents.queryItems = parameters.map { (key, value) in
            return URLQueryItem(name: key, value: "\(value)")
        }
        
        return urlComponents.url ?? self
    }
}

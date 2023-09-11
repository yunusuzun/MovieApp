//
//  APIConstants.swift
//  MovieApp
//
//  Created by Yunus Uzun on 8.09.2023.
//

struct APIConstants {
    static let baseURL = "http://www.omdbapi.com"
    static let apiKey = "28ddd509"
}

struct Header {
    struct Key {
        static let contentType = "Content-Type"
    }
    
    struct Value {
        static let json = "application/json"
    }
}

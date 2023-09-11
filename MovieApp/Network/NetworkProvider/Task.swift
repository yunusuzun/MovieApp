//
//  Task.swift
//  MovieApp
//
//  Created by Yunus Uzun on 7.09.2023.
//

enum Task {
    case requestPlain
    case requestParameters(body: Encodable? = nil, query: [String: Any]? = nil)
}

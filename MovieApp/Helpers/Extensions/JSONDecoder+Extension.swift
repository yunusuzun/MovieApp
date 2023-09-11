//
//  JSONDecoder+Extension.swift
//  MovieApp
//
//  Created by Yunus Uzun on 7.09.2023.
//

import Foundation

protocol ResponseDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

extension JSONDecoder: ResponseDecoder { }

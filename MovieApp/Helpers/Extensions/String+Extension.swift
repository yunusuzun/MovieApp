//
//  String+Extension.swift
//  MovieApp
//
//  Created by Yunus Uzun on 7.09.2023.
//

extension String {
    static var empty: Self {
        ""
    }
    
    var stringByRemovingWhitespaces: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var capitalizeFirstLetter: String {
        guard !isEmpty else { return self }
        return prefix(1).capitalized + dropFirst()
    }
}

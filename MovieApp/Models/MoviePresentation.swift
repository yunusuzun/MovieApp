//
//  MoviePresentation.swift
//  MovieApp
//
//  Created by Yunus Uzun on 7.09.2023.
//

struct MoviePresentation {
    let title, year: String?
    let type: TypeEnum?
    let poster: String?
    let imdbID: String?
    
    init(movie: Search) {
        self.title = movie.title
        self.poster = movie.poster
        self.type = movie.type
        self.year = movie.year
        self.imdbID = movie.imdbID
    }
}

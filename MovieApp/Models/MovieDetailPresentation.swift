//
//  MovieDetailPresentation.swift
//  MovieApp
//
//  Created by Yunus Uzun on 8.09.2023.
//

struct MovieDetailPresentation {
    let poster: String?
    let title: String?
    let type: String?
    let year: String?
    let lenght: String?
    let country: String?
    let description: String?
    
    init(movie: MovieDetailEntity) {
        poster = movie.poster
        title = movie.title
        type = movie.type
        year = movie.year
        lenght = movie.runtime
        country = movie.country
        description = movie.plot
    }
}

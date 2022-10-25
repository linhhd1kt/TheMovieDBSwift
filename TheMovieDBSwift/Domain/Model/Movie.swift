//
//  Movie.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 19/10/2022.
//

import Foundation

struct Movie {
    let id: Int
    let posterPath: String
    let adult: Bool
    let overview: String
    let releaseDate: String
    let genreIds: [Int]
    let originalTitle: String
    let originalLanguage: String
    let title: String
    let backdropPath: String
    let popularity: Double
    let voteCount: Int
    let video: Bool
    let voteAverage: Double
}

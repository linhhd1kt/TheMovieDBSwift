//
//  MovieResponse.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 20/10/2022.
//

import Foundation

struct MoviesResponse: Decodable {
    let page: Int
    let results: [Data]
    let totalResults: Int
    let totalPages: Int
    
    struct Data: Codable {
        let posterPath: String
        let adult: Bool
        let overview: String
        let releaseDate: String
        let genreIds: [Int]
        let id: Int
        let originalTitle: String
        let originalLanguage: String
        let title: String
        let backdropPath: String
        let popularity: Double
        let voteCount: Int
        let video: Bool
        let voteAverage: Double
    }
}

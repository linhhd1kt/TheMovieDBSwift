//
//  MovieTranslator.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 20/10/2022.
//

import Foundation

protocol MovieTranslatorType {
    func toPopularRequest(page: Int) -> PopularMovieRequest
    func toDiscoverRequest(page: Int, monetization: MonetizationType) -> DiscoverMovieRequest
    func toModels(response: MoviesResponse) -> [Movie]
    func toModel(response: MoviesResponse.Data) -> Movie
    func toPage(response: MoviesResponse) -> MoviePage
}

struct MovieTranslator: MovieTranslatorType {
    func toPopularRequest(page: Int) -> PopularMovieRequest {
        return PopularMovieRequest(page: page)
    }
    
    func toDiscoverRequest(page: Int, monetization: MonetizationType) -> DiscoverMovieRequest {
        return DiscoverMovieRequest(page: page, monetization: monetization)
    }
    
    func toModel(response: MoviesResponse.Data) -> Movie {
        return Movie(id: response.id,
                     posterPath: response.posterPath,
                     adult: response.adult,
                     overview: response.overview,
                     releaseDate: response.releaseDate,
                     genreIds: response.genreIDS,
                     originalTitle: response.originalTitle,
                     originalLanguage: response.originalLanguage,
                     title: response.title,
                     backdropPath: response.backdropPath,
                     popularity: response.popularity,
                     voteCount: response.voteCount,
                     video: response.video,
                     voteAverage: response.voteAverage)
    }
    
    func toModels(response: MoviesResponse) -> [Movie] {
        response.results.map { toModel(response: $0) }
    }
    
    func toPage(response: MoviesResponse) -> MoviePage {
        return MoviePage(page: response.page,
                         results: response.results.map { toModel(response: $0) },
                         totalResults: response.totalResults,
                         totalPages: response.totalPages)
    }
}

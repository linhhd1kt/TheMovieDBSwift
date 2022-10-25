//
//  MovieTranslator.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 20/10/2022.
//

import Foundation

protocol MovieTranslatorType {
    func toPopularRequest(page: Int) -> PopularMovieRequest
    func toModels(response: MoviesResponse) -> [Movie]
    func toModel(response: MoviesResponse.Data) -> Movie
    func toPage(response: MoviesResponse) -> Page<Movie>
}

struct MovieTranslator: MovieTranslatorType {
    func toPopularRequest(page: Int) -> PopularMovieRequest {
        return PopularMovieRequest(page: page)
    }
    
    func toModel(response: MoviesResponse.Data) -> Movie {
        return Movie(id: response.id,
                     posterPath: response.posterPath,
                     adult: response.adult,
                     overview: response.overview,
                     releaseDate: response.releaseDate,
                     genreIds: response.genreIds,
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
    
    func toPage(response: MoviesResponse) -> Page<Movie> {
        return Page(page: response.page,
                    results: response.results.map { toModel(response: $0) },
                    totalResults: response.totalResults,
                    totalPages: response.totalPages)
    }
}


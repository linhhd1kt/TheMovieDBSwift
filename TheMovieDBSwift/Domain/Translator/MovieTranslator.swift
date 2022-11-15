//
//  MovieTranslator.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 20/10/2022.
//

import Foundation

protocol MovieTranslatorType {
    func toPopularRequest(page: Int, category: DiscoverCategory) -> PopularMovieRequest
    func toFreeWatchMovieRequest(page: Int) -> FreeWatchMovieRequest
    func toFreeWatchTVRequest(page: Int) -> FreeWatchTVRequest
    func toModels(response: MoviesResponse) -> [Movie]
    func toModel(response: MoviesResponse.Data) -> Movie
    func toPage(response: MoviesResponse) -> MoviePage
}

struct MovieTranslator: MovieTranslatorType {
    func toPopularRequest(page: Int, category: DiscoverCategory) -> PopularMovieRequest {
        let monetization: MonetizationType
        var releaseTypes = Set<ReleaseType>()
        switch category {
        case .streaming:
            monetization = .flatrate
        case .onTV:
            monetization = .none
            releaseTypes.insert(.TV)
        case .forRent:
            monetization = .rent
        case .onThreaters:
            monetization = .none
            releaseTypes.insert(.theatrical)
            releaseTypes.insert(.theatricalLimited)
        default:
            monetization = .none
        }
        return PopularMovieRequest(page: page, monetization: monetization, releaseTypes: releaseTypes)
    }
    
    func toFreeWatchMovieRequest(page: Int) -> FreeWatchMovieRequest {
        return FreeWatchMovieRequest(page: page)
    }
    
    func toFreeWatchTVRequest(page: Int) -> FreeWatchTVRequest {
        return FreeWatchTVRequest(page: page)
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

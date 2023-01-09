//
//  MovieTranslator.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Data

public struct MovieTranslator: MovieTranslatorType {
  
  public init() { }
  
  public func toPopularMovieRequest(page: Int, category: DiscoverCategory) -> PopularMovieRequest {
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

  public func toFreeWatchMovieRequest(page: Int) -> FreeWatchMovieRequest {
    return FreeWatchMovieRequest(page: page)
  }

  public func toTrendingMovieRequest(timeWindow: TimeWindow) -> TrendingMovieRequest {
    return TrendingMovieRequest(page: 1, mediaType: .all, timeWindow: timeWindow)
  }

  public func toModel(response: MovieResponse.Data) -> Movie {
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

  public func toModels(response: MovieResponse) -> [Movie] {
    response.results.map { toModel(response: $0) }
  }

  public func toPage(response: MovieResponse) -> MoviePage {
    return MoviePage(page: response.page,
                     results: response.results.map { toModel(response: $0) },
                     totalResults: response.totalResults,
                     totalPages: response.totalPages)
  }
}

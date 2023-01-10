//
//  TvTranslator.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Data

public struct TvTranslator: TvTranslatorType {
  
  public init() { }

  public func toFreeWatchTvRequest(page: Int) -> FreeWatchTvRequest {
    return FreeWatchTvRequest(page: page)
  }
  
  public func toTrendingTvRequest(timeWindow: TimeWindow) -> TrendingTvRequest {
    return TrendingTvRequest(page: 1, mediaType: .all, timeWindow: timeWindow)
  }
  
  public func toModel(response: TvResponse.Data) -> Tv {
    return Tv(id: response.id,
              posterPath: response.posterPath,
              originCountry: response.originCountry,
              overview: response.overview,
              firstAirDate: response.firstAirDate,
              genreIds: response.genreIDS,
              originalName: response.originalName,
              originalLanguage: response.originalLanguage,
              name: response.name,
              backdropPath: response.backdropPath,
              popularity: response.popularity,
              voteCount: response.voteCount,
              video: response.video,
              voteAverage: response.voteAverage)
  }
  
  public func toModels(response: TvResponse) -> [Tv] {
    response.results.map { toModel(response: $0) }
  }
  
  public func toPage(response: TvResponse) -> MediaPage {
    return MediaPage(page: response.page,
                     results: response.results.map { toModel(response: $0) },
                     totalResults: response.totalResults,
                     totalPages: response.totalPages)
  }
}

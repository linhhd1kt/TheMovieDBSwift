//
//  MovieTranslatorType.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Data

public protocol MovieTranslatorType {
  func toDiscoverRequest(page: Int, category: DiscoverCategory) -> DiscoverMovieRequest
  func toFreeWatchMovieRequest(page: Int) -> FreeWatchMovieRequest
  func toTrendingMovieRequest(timeWindow: TimeWindow) -> TrendingMovieRequest
  func toModels(response: MovieResponse) -> [Movie]
  func toModel(response: MovieResponse.Data) -> Movie
  func toPage(response: MovieResponse) -> MediaPage
}

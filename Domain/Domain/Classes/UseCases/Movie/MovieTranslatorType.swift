//
//  MovieTranslatorType.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Data

public protocol MovieTranslatorType {
  func toPopularRequest(page: Int, category: DiscoverCategory) -> PopularMovieRequest
  func toFreeWatchMovieRequest(page: Int) -> FreeWatchMovieRequest
  func toFreeWatchTVRequest(page: Int) -> FreeWatchTVRequest
  func toTrendingRequest(timeWindow: TimeWindow) -> TrendingRequest
  func toModels(response: MoviesResponse) -> [Movie]
  func toModel(response: MoviesResponse.Data) -> Movie
  func toPage(response: MoviesResponse) -> MoviePage
}

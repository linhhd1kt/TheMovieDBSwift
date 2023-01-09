//
//  MovieTranslatorType.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Data

public protocol MovieTranslatorType {
  func toPopularMovieRequest(page: Int, category: DiscoverCategory) -> PopularMovieRequest
  func toFreeWatchMovieRequest(page: Int) -> FreeWatchMovieRequest
  func toTrendingMovieRequest(timeWindow: TimeWindow) -> TrendingMovieRequest
  func toModels(response: MovieResponse) -> [Movie]
  func toModel(response: MovieResponse.Data) -> Movie
  func toPage(response: MovieResponse) -> MoviePage
}

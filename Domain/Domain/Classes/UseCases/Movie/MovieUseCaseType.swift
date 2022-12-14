//
//  MovieUseCaseType.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import RxSwift
import Data
import Extension

public protocol MovieUseCaseType {
  var input: MovieUseCaseInputType { get }
  var output: MovieUseCaseOutputType { get }
}

public protocol MovieUseCaseInputType {
  var fetchPopular: AnyObserver<(page: Int, category: DiscoverCategory)> { get }
  var fetchFreeWatchMovie: AnyObserver<(page: Int, category: DiscoverCategory)> { get }
  var fetchTrending: AnyObserver<TimeWindow> { get }
}

public protocol MovieUseCaseOutputType {
  var fetchPopularResult: ActionResult<MediaPage> { get }
  var fetchFreeWatchMovieResult: ActionResult<MediaPage> { get }
  var fetchTrendingResult: ActionResult<MediaPage> { get }
}

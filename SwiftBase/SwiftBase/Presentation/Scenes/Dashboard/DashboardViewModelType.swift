//
//  DashboardViewModelType.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import RxSwift
import Domain
import Extension
import Data

protocol DashboardViewModelType {
  var input: DashboardViewModelInputType { get }
  var output: DashboardViewModelOutputType { get }
}

protocol DashboardViewModelInputType {
  var fetchDiscoverMovies: AnyObserver<(page: Int, category: DiscoverCategory)> { get }
  var fetchFreeWatchMovies: AnyObserver<(page: Int, category: DiscoverCategory)> { get }
  var fetchFreeWatchTvs: AnyObserver<(page: Int, category: DiscoverCategory)> { get }
  var fetchTrending: AnyObserver<DiscoverCategory> { get }
}

protocol DashboardViewModelOutputType {
  var fetchPopularResult: ActionResult<MoviePage> { get }
  var fetchFreeWatchMoviesResult: ActionResult<MoviePage> { get }
  var fetchFreeWatchTvsResult: ActionResult<TvPage> { get }
  var fetchTrendingMoviesResult: ActionResult<MoviePage> { get }
  var fetchTrendingTvsResult: ActionResult<TvPage> { get }
}

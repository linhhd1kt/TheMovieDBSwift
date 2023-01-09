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
  var fetchTrending: AnyObserver<DiscoverCategory> { get }
}

protocol DashboardViewModelOutputType {
  var fetchPopularResult: Observable<MoviePage> { get }
  var fetchFreeWatchResult: Observable<MoviePage> { get }
  var fetchTrendingResult: Observable<MoviePage> { get }
}

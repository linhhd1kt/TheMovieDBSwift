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
  var fetchDiscover: AnyObserver<(page: Int, category: DiscoverCategory)> { get }
  var fetchFreeWatchMovie: AnyObserver<(page: Int, category: DiscoverCategory)> { get }
  var fetchFreeWatchTv: AnyObserver<(page: Int, category: DiscoverCategory)> { get }
  var fetchTrending: AnyObserver<DiscoverCategory> { get }
}
protocol DashboardViewModelOutputType {
  var fetchPopularResult: ActionResult<MediaPage> { get }
  var fetchFreeWatchMovieResult: ActionResult<MediaPage> { get }
  var fetchFreeWatchTvResult: ActionResult<MediaPage> { get }
  var fetchTrendingResult: ActionResult<MediaPage> { get }
}

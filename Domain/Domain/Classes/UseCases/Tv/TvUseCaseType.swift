//
//  TvUseCaseType.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import RxSwift
import Data
import Extension

public protocol TvUseCaseType {
  var input: TvUseCaseInputType { get }
  var output: TvUseCaseOutputType { get }
}

public protocol TvUseCaseInputType {
  var fetchFreeWatchTv: AnyObserver<(page: Int, category: DiscoverCategory)> { get }
  var fetchTrending: AnyObserver<TimeWindow> { get }
}

public protocol TvUseCaseOutputType {
  var fetchFreeWatchTvResult: ActionResult<MediaPage> { get }
  var fetchTrendingResult: ActionResult<MediaPage> { get }
}

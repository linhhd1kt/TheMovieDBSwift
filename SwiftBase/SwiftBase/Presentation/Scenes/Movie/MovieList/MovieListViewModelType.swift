//
//  MovieListViewModelType.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import RxSwift
import Data
import Domain

public protocol MovieListViewModelType {
  var input: MovieListViewModelInputType { get }
  var output: MovieListViewModelOutputType { get }
}

public protocol MovieListViewModelInputType {
  var nextPageTrigger: AnyObserver<(page: Int, category: DiscoverCategory)> { get }
}

public protocol MovieListViewModelOutputType {
  var fetchMovieResult: Observable<MoviePage> { get }
}

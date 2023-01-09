//
//  DashboardViewModel.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Action
import Domain
import RxCocoa
import RxSwift
import Data
import Extension

final class DashboardViewModel: BaseViewModel {
  // MARK: - Dependency

  private let movieUseCase: MovieUseCaseType
  private let tvUseCase: TvUseCaseType

  // MARK: - Input

  private let fetchPopularObserver = PublishSubject<(page: Int, category: DiscoverCategory)>()
  private let fetchFreeWatchMovieObserver = PublishSubject<(page: Int, category: DiscoverCategory)>()
  private let fetchFreeWatchTvObserver = PublishSubject<(page: Int, category: DiscoverCategory)>()
  private let fetchTrendingObserver = PublishSubject<DiscoverCategory>()

  // MARK: - Output

  private let errorObserver = BehaviorSubject<String>(value: "")
  private let popularResultObserver = BehaviorSubject<MoviePage>(value: .init())
  private let freeWatchMovieResultObserver = BehaviorSubject<MoviePage>(value: .init())
  private let freeWatchTvResultObserver = BehaviorSubject<TvPage>(value: .init())
  private let trendingResultObserver = BehaviorSubject<MoviePage>(value: .init())

  init(movieUseCase: MovieUseCaseType, tvUseCase: TvUseCaseType) {
    self.movieUseCase = movieUseCase
    self.tvUseCase = tvUseCase
    super.init()
    binding()
  }

  private func binding() {
    // fetch popular
    fetchPopularObserver
      .bind(to: movieUseCase.input.fetchPopular)
      .disposed(by: disposeBag)
    // fetch free watch
    fetchFreeWatchMovieObserver
      .bind(to: movieUseCase.input.fetchFreeWatchMovie)
      .disposed(by: disposeBag)
    fetchFreeWatchTvObserver
      .bind(to: tvUseCase.input.fetchFreeWatchTv)
      .disposed(by: disposeBag)
    // fetch trending
    fetchTrendingObserver
      .map { TimeWindow(rawValue: $0.rawValue) ?? .day }
      .bind(to: movieUseCase.input.fetchTrending)
      .disposed(by: disposeBag)
  }
}

extension DashboardViewModel: DashboardViewModelType {
  var input: DashboardViewModelInputType {
    return self
  }

  var output: DashboardViewModelOutputType {
    return self
  }
}

extension DashboardViewModel: DashboardViewModelInputType {
  var fetchDiscoverMovies: AnyObserver<(page: Int, category: DiscoverCategory)> {
    return fetchPopularObserver.asObserver()
  }
  var fetchFreeWatchMovies: AnyObserver<(page: Int, category: DiscoverCategory)> {
    return fetchFreeWatchMovieObserver.asObserver()
  }
  var fetchFreeWatchTvs: AnyObserver<(page: Int, category: DiscoverCategory)> {
    return fetchFreeWatchTvObserver.asObserver()
  }
  var fetchTrending: AnyObserver<DiscoverCategory> {
    return fetchTrendingObserver.asObserver()
  }
}

extension DashboardViewModel: DashboardViewModelOutputType {
  var fetchPopularResult: ActionResult<MoviePage> {
    return movieUseCase.output.fetchPopularResult
  }
  var fetchFreeWatchMoviesResult: ActionResult<MoviePage> {
    return movieUseCase.output.fetchFreeWatchMovieResult
  }
  var fetchTrendingMoviesResult: ActionResult<MoviePage> {
    return movieUseCase.output.fetchTrendingResult
  }
  var fetchFreeWatchTvsResult: ActionResult<TvPage> {
    return tvUseCase.output.fetchFreeWatchTvResult
  }
  
  var fetchTrendingTvsResult: ActionResult<TvPage> {
    return tvUseCase.output.fetchTrendingResult
  }
}

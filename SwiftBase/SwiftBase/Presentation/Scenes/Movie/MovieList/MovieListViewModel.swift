//
//  MovieListViewModel.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Action
import RxCocoa
import RxSwift
import Domain
import Data

public final class MovieListViewModel: BaseViewModel {
  // MARK: - Dependency

  private let movieUseCase: MovieUseCaseType

  // MARK: - Input

  private let nextPageObserver = PublishSubject<(page: Int, category: DiscoverCategory)>()
  //    private let movieSelectedObserver = PublishSubject<Movie?>()

  // MARK: - Output

  private let errorObserver = BehaviorSubject<String>(value: "")
  private var movieListObserver = BehaviorRelay<MoviePage>(value: .empty)

  public init(movieUseCase: MovieUseCaseType) {
    self.movieUseCase = movieUseCase
    super.init()
    binding()
  }
}

extension MovieListViewModel: MovieListViewModelType {
  public var input: MovieListViewModelInputType {
    return self
  }

  public var output: MovieListViewModelOutputType {
    return self
  }

  func binding() {
    nextPageObserver
      .bind(to: movieUseCase.input.fetchPopular)
      .disposed(by: disposeBag)
    movieUseCase
      .output
      .fetchPopularResult
      .elements
      .bind(to: movieListObserver)
      .disposed(by: disposeBag)
  }
}

extension MovieListViewModel: MovieListViewModelInputType {
  public var nextPageTrigger: AnyObserver<(page: Int, category: DiscoverCategory)> {
    return nextPageObserver.asObserver()
  }
}

extension MovieListViewModel: MovieListViewModelOutputType {
  public var fetchMovieResult: Observable<MoviePage> {
    return movieListObserver.asObservable()
  }
}

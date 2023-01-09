//
//  MovieUseCase.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import RxSwift
import Data
import Extension

public class MovieUseCase {
  // MARK: - Dependency

  private let repository: MovieRepositoryType
  private let translator: MovieTranslatorType

  private let fetchPopularObserver = PublishSubject<(page: Int, category: DiscoverCategory)>()
  private let fetchFreeWatchMovieObserver = PublishSubject<(page: Int, category: DiscoverCategory)>()
  private let fetchFreeWatchTVObserver = PublishSubject<(page: Int, category: DiscoverCategory)>()
  private let fetchTrendingObserver = PublishSubject<TimeWindow>()

  // MARK: - Other

  public init(repository: MovieRepositoryType, translator: MovieTranslatorType) {
    self.repository = repository
    self.translator = translator
    bindInput()
  }

  private func bindInput() {
    fetchPopularObserver
      .withUnretained(self)
      .map { this, info in
        this.translator.toPopularRequest(page: info.page, category: info.category)
      }
      .bind(to: repository.fetchPopularMovie.inputs)
      .disposed(by: disposeBag)

    fetchFreeWatchMovieObserver
      .map { $0.page }
      .withUnretained(self)
      .map { this, page in this.translator.toFreeWatchMovieRequest(page: page) }
      .bind(to: repository.fetchFreeWatchMovie.inputs)
      .disposed(by: disposeBag)

    fetchFreeWatchTVObserver
      .map { $0.page }
      .withUnretained(self)
      .map { this, page in this.translator.toFreeWatchTVRequest(page: page) }
      .bind(to: repository.fetchFreeWatchTV.inputs)
      .disposed(by: disposeBag)

    fetchTrendingObserver
      .withUnretained(self)
      .map { this, timeWindow in
        this.translator.toTrendingRequest(timeWindow: timeWindow)
      }
      .bind(to: repository.fetchTrending.inputs)
      .disposed(by: disposeBag)
  }
}

// MARK: - MovieUseCaseType

extension MovieUseCase: MovieUseCaseType {
  public var input: MovieUseCaseInputType { return self }
  public var output: MovieUseCaseOutputType { return self }
}

// MARK: - MovieUseCaseInputType

extension MovieUseCase: MovieUseCaseInputType {
  public var fetchPopular: AnyObserver<(page: Int, category: DiscoverCategory)> {
    fetchPopularObserver.asObserver()
  }

  public var fetchFreeWatchMovie: AnyObserver<(page: Int, category: DiscoverCategory)> {
    return fetchFreeWatchMovieObserver.asObserver()
  }

  public var fetchFreeWatchTV: AnyObserver<(page: Int, category: DiscoverCategory)> {
    return fetchFreeWatchTVObserver.asObserver()
  }

  public var fetchTrending: AnyObserver<TimeWindow> {
    fetchTrendingObserver.asObserver()
  }
}

// MARK: - MovieUseCaseOutputType

extension MovieUseCase: MovieUseCaseOutputType {
  public var fetchPopularResult: ActionResult<MoviePage> {
    return repository.fetchPopularMovie.toResult()
      .map { self.translator.toPage(response: $0) }
  }

  public var fetchFreeWatchMovieResult: ActionResult<MoviePage> {
    return repository.fetchFreeWatchMovie.toResult()
      .map { self.translator.toPage(response: $0) }
  }

  public var fetchFreeWatchTVResult: ActionResult<MoviePage> {
    return repository.fetchFreeWatchTV.toResult()
      .map { self.translator.toPage(response: $0) }
  }

  public var fetchTrendingResult: ActionResult<MoviePage> {
    return repository.fetchTrending.toResult()
      .map { self.translator.toPage(response: $0) }
  }
}

extension MovieUseCase: HasDisposeBag {}

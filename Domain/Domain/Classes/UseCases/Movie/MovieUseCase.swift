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
  private let repository: MovieRepositoryType
  private let translator: MovieTranslatorType

  private let fetchDiscoverMovieObserver = PublishSubject<(page: Int, category: DiscoverCategory)>()
  private let fetchFreeWatchMovieObserver = PublishSubject<(page: Int, category: DiscoverCategory)>()
  private let fetchTrendingMovieObserver = PublishSubject<TimeWindow>()

  public init(repository: MovieRepositoryType, translator: MovieTranslatorType) {
    self.repository = repository
    self.translator = translator
    bindInput()
  }

  private func bindInput() {
    fetchDiscoverMovieObserver
      .withUnretained(self)
      .map { this, info in
          this.translator.toDiscoverRequest(page: info.page, category: info.category)
      }
      .bind(to: repository.fetchDiscoverMovie.inputs)
      .disposed(by: disposeBag)
    fetchFreeWatchMovieObserver
      .map { $0.page }
      .withUnretained(self)
      .map { this, page in this.translator.toFreeWatchMovieRequest(page: page) }
      .bind(to: repository.fetchFreeWatchMovie.inputs)
      .disposed(by: disposeBag)
    fetchTrendingMovieObserver
      .withUnretained(self)
      .map { this, timeWindow in
        this.translator.toTrendingMovieRequest(timeWindow: timeWindow)
      }
      .bind(to: repository.fetchTrendingMovie.inputs)
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
    fetchDiscoverMovieObserver.asObserver()
  }
  public var fetchFreeWatchMovie: AnyObserver<(page: Int, category: DiscoverCategory)> {
    return fetchFreeWatchMovieObserver.asObserver()
  }
  public var fetchTrending: AnyObserver<TimeWindow> {
    fetchTrendingMovieObserver.asObserver()
  }
}

// MARK: - MovieUseCaseOutputType
extension MovieUseCase: MovieUseCaseOutputType {
  public var fetchPopularResult: ActionResult<MediaPage> {
    return repository.fetchDiscoverMovie.toResult()
      .map { self.translator.toPage(response: $0) }
  }
  public var fetchFreeWatchMovieResult: ActionResult<MediaPage> {
    return repository.fetchFreeWatchMovie.toResult()
      .map { self.translator.toPage(response: $0) }
  }
  public var fetchFreeWatchTVResult: ActionResult<MediaPage> {
    return repository.fetchFreeWatchMovie.toResult()
      .map { self.translator.toPage(response: $0) }
  }
  public var fetchTrendingResult: ActionResult<MediaPage> {
    return repository.fetchTrendingMovie.toResult()
      .map { self.translator.toPage(response: $0) }
  }
}

extension MovieUseCase: HasDisposeBag {}

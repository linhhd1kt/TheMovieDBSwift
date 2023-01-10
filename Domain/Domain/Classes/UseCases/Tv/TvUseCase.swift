//
//  TvUseCase.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import RxSwift
import Data
import Extension

public class TvUseCase {
  // MARK: - Dependency

  private let repository: TvRepositoryType
  private let translator: TvTranslatorType

  private let fetchFreeWatchTvObserver = PublishSubject<(page: Int, category: DiscoverCategory)>()
  private let fetchTrendingObserver = PublishSubject<TimeWindow>()

  // MARK: - Other

  public init(repository: TvRepositoryType, translator: TvTranslatorType) {
    self.repository = repository
    self.translator = translator
    bindInput()
  }

  private func bindInput() {
    fetchFreeWatchTvObserver
      .map { $0.page }
      .withUnretained(self)
      .map { this, page in this.translator.toFreeWatchTvRequest(page: page) }
      .bind(to: repository.fetchFreeWatchTv.inputs)
      .disposed(by: disposeBag)

    fetchTrendingObserver
      .withUnretained(self)
      .map { this, timeWindow in
        this.translator.toTrendingTvRequest(timeWindow: timeWindow)
      }
      .bind(to: repository.fetchTrendingTv.inputs)
      .disposed(by: disposeBag)
  }
}

// MARK: - TvUseCaseType

extension TvUseCase: TvUseCaseType {
  public var input: TvUseCaseInputType { return self }
  public var output: TvUseCaseOutputType { return self }
}

// MARK: - TvUseCaseInputType

extension TvUseCase: TvUseCaseInputType {
  public var fetchFreeWatchTv: AnyObserver<(page: Int, category: DiscoverCategory)> {
    return fetchFreeWatchTvObserver.asObserver()
  }

  public var fetchFreeWatchTV: AnyObserver<(page: Int, category: DiscoverCategory)> {
    return fetchFreeWatchTv.asObserver()
  }

  public var fetchTrending: AnyObserver<TimeWindow> {
    fetchTrendingObserver.asObserver()
  }
}

// MARK: - TvUseCaseOutputType

extension TvUseCase: TvUseCaseOutputType {
  public var fetchFreeWatchTvResult: ActionResult<MediaPage> {
    return repository.fetchFreeWatchTv.toResult()
      .map { self.translator.toPage(response: $0) }
  }
  
  public var fetchTrendingResult: ActionResult<MediaPage> {
    return repository.fetchTrendingTv.toResult()
      .map { self.translator.toPage(response: $0) }
  }
}

extension TvUseCase: HasDisposeBag {}

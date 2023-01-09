//
//  ErrorTracker.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Foundation
import RxCocoa
import RxSwift

public extension ObservableType {
  func catchErrorJustComplete() -> Observable<Element> {
    `catch` { _ in
      Observable.empty()
    }
  }

  func asDriverOnErrorJustComplete() -> Driver<Element> {
    asDriver { _ in
      Driver.empty()
    }
  }
}

public final class ErrorTracker: SharedSequenceConvertibleType {
  public typealias SharingStrategy = DriverSharingStrategy
  private let _subject = PublishSubject<Error>()

  fileprivate func trackErrorOfObservable<Source: ObservableConvertibleType>(from source: Source) -> Observable<Source.Element> {
    source.asObservable()
      .debug("ErrorTracker")
      .do(onError: onError)
  }

  fileprivate func trackErrorOfSingle<Element>(from source: Single<Element>) -> Single<Element> {
    source.do(onError: onError)
  }

  public func asSharedSequence() -> SharedSequence<SharingStrategy, Error> {
    _subject.asObservable()
      .asDriverOnErrorJustComplete()
  }

  public func asObservable() -> Observable<Error> {
    _subject.asObservable()
  }

  private func onError(_ error: Error) {
    _subject.onNext(error)
  }

  deinit {
    _subject.onCompleted()
  }
}

public extension ObservableConvertibleType {
  func trackError(_ errorTracker: ErrorTracker) -> Observable<Element> {
    errorTracker.trackErrorOfObservable(from: self)
  }
}

public extension PrimitiveSequence where Trait == SingleTrait {
  func trackError(_ errorTracker: ErrorTracker) -> Single<Element> {
    errorTracker.trackErrorOfSingle(from: self)
  }
}

//
//  Page.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import RxSwift
import RxCocoa

public protocol Paginated {
  associatedtype Element

  var page: Int { get set }
  var results: [Element] { get set }
  var totalResults: Int { get set }
  var totalPages: Int { get set }

  init()
}

public extension BehaviorRelay where Element: Paginated {
  var append: AnyObserver<Element> {
    AnyObserver { [weak self] event in
      guard let self = self else {
        return
      }
      switch event {
      case let .next(data):
        var newValue = self.value
        newValue.page = data.page
        newValue.totalPages = data.totalPages
        newValue.totalResults = data.totalResults
        newValue.results += data.results
        self.accept(newValue)
      default:
        break
      }
    }
  }
}

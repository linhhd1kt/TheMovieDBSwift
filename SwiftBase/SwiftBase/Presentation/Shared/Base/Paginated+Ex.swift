//
//  Paginated+Ex.swift
//  Action
//
//  Created by Ha Linh on 05/01/2023.
//

import RxSwift
import Domain
import RxCocoa
import Data

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


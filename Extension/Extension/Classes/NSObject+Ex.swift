//
//  NSObject+Ex.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Foundation
import ObjectiveC
import RxSwift

private var disposeBagContext: UInt8 = 0

public extension NSObject {
  class var className: String {
    return String(describing: self)
  }

  var className: String {
    return type(of: self).className
  }
}

extension Reactive where Base: AnyObject {
  func synchronizedBag<T>(_ action: () -> T) -> T {
    objc_sync_enter(base)
    let result = action()
    objc_sync_exit(base)
    return result
  }
}

public extension Reactive where Base: AnyObject {
  /// a unique DisposeBag that is related to the Reactive.Base instance only for Reference type
  var disposeBag: DisposeBag {
    get {
      return synchronizedBag {
        if let disposeObject = objc_getAssociatedObject(base, &disposeBagContext) as? DisposeBag {
          return disposeObject
        }
        let disposeObject = DisposeBag()
        objc_setAssociatedObject(base, &disposeBagContext, disposeObject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return disposeObject
      }
    }
    set {
      synchronizedBag {
        objc_setAssociatedObject(base, &disposeBagContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      }
    }
  }
}

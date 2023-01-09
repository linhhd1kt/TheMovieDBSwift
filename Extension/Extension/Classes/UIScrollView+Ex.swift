//
//  UIScrollView+Ex.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import RxSwift
import UIKit

public extension Reactive where Base: UITableView {
  var reachEnd: Observable<Void> {
    // capture base to avoiding retain cycle
    // swiftlint:disable implicitly_unwrapped_optional
    weak var base: UITableView! = base
    return base.rx.contentOffset
      .filter { ($0.x + $0.y) > 0.0 }
      .map { $0.y + base.frame.size.height + 20.0 > base.contentSize.height }
      .distinctUntilChanged()
      .filter { $0 }
      .map { _ in }
  }
}

public extension Reactive where Base: UICollectionView {
  var reachEnd: Observable<Void> {
    // capture base to avoiding retain cycle
    // swiftlint:disable implicitly_unwrapped_optional
    weak var base: UICollectionView! = base
    return base.rx.contentOffset
      .filter { ($0.x + $0.y) > 0.0 }
      .map { $0.x + base.frame.size.width + 20.0 > base.contentSize.width }
      .distinctUntilChanged()
      .filter { $0 }
      .map { _ in }
  }
}

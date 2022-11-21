//
//  UIScrollView+Ex.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 04/11/2022.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UITableView {
    var reachEnd: Observable<Void> {
        // capture base to avoiding retain cycle
        // swiftlint:disable implicitly_unwrapped_optional
        weak var base: UITableView! = base
        return base.rx.contentOffset
            .filter { ($0.x + $0.y) > 0.0 }
            .map { $0.y + base.frame.size.height + 20.0 > base.contentSize.height }
            .distinctUntilChanged()
            .filter { $0 }
            .map { _ in return }
    }
}

extension Reactive where Base: UICollectionView {
    var reachEnd: Observable<Void> {
        // capture base to avoiding retain cycle
        // swiftlint:disable implicitly_unwrapped_optional
        weak var base: UICollectionView! = base
        return base.rx.contentOffset
            .filter { ($0.x + $0.y) > 0.0 }
            .map { $0.x + base.frame.size.width + 20.0 > base.contentSize.width }
            .distinctUntilChanged()
            .filter { $0 }
            .map { _ in return }
    }
}

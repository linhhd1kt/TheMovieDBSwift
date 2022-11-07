//
//  UIScrollView+Ex.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 04/11/2022.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIScrollView {
    var reachEnd: Observable<Void> {
        return base.rx.contentOffset
            .filter { ($0.x + $0.y) > 0.0 }
            .map { $0.y + base.frame.size.height + 20.0 > base.contentSize.height }
            .distinctUntilChanged()
            .filter { $0 }
            .map { _ in return }
    }
}
//
//  UIViewControler+Rx.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Action
import RxSwift
import SVProgressHUD

public extension Reactive where Base: UIViewController {
  var loading: Binder<Bool> {
    return Binder(base) { _, isLoading in
      if isLoading {
        SVProgressHUD.show()
      } else {
        SVProgressHUD.dismiss()
      }
    }
  }

  var viewWillAppearOnce: Observable<Void> {
    return sentMessage(#selector(base.viewWillAppear(_:)))
      .take(1)
      .map { _ in () }
      .share(replay: 1)
  }

  var viewWillAppearSkip: Observable<Void> {
    return sentMessage(#selector(base.viewWillAppear(_:)))
      .skip(1)
      .map { _ in () }
      .share(replay: 1)
  }

  var viewWillAppear: Observable<Void> {
    return sentMessage(#selector(base.viewWillAppear(_:)))
      .map { _ in () }
      .share(replay: 1)
  }

  var viewDidAppear: Observable<Void> {
    return sentMessage(#selector(base.viewDidAppear(_:)))
      .map { _ in () }
      .share(replay: 1)
  }

  var viewWillDisappear: Observable<Void> {
    return sentMessage(#selector(base.viewWillDisappear(_:)))
      .map { _ in () }
      .share(replay: 1)
  }

  var viewDidDisappear: Observable<Void> {
    return sentMessage(#selector(base.viewDidDisappear(_:)))
      .map { _ in () }
      .share(replay: 1)
  }
}

//
//  UIViewControler+Rx.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 12/10/2022.
//

import RxCocoa
import RxSwift
import UIKit
import Action
import ProgressHUD

extension Reactive where Base: UIViewController {
    var showError: Binder<ActionError> {
        return Binder(self.base) { view, actionError in
            var message: String
            switch actionError {
            case .notEnabled:
                message = "Action Not Enabled"
            case .underlyingError(let error):
                message = error.localizedDescription
            }
            let alert = UIAlertController(title: "Error",
                                          message: message,
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
            view.present(alert, animated: true)
        }
    }
    
    var loading: Binder<Bool> {
        return Binder(self.base) { view, isLoading in
            ProgressHUD.colorBackground = .clear
            ProgressHUD.colorHUD = .clear
            ProgressHUD.colorProgress = .clear
            ProgressHUD.colorAnimation = .clear
            ProgressHUD.colorAnimation  = .cyan
            if isLoading {
                ProgressHUD.showSucceed()
            } else {
                ProgressHUD.dismiss()
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

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
}

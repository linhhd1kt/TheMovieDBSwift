//
//  ViewController.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 22/09/2022.
//

import UIKit
import RxCocoa
import RxSwift
import NSObject_Rx

extension UIViewController: HasDisposeBag {}

extension Reactive where Base: UIViewController {
  var error: Binder<Error> {
      return Binder(self.base) { view, error in
          let message = error.localizedDescription
          let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
          let action = UIAlertAction(title: "OK", style: .default)
          alert.addAction(action)
          view.present(alert, animated: true)
      }
  }
}

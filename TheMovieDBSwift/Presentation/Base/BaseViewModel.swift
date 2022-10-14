//
//  ViewModel.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 22/09/2022.
//

import RxSwift
import NSObject_Rx
import UIKit

class BaseViewModel {
    init() { }
    deinit {
        print("\(type(of: self)): deinit")
    }
}

extension BaseViewModel: HasDisposeBag {}

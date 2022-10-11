//
//  ViewModel.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 22/09/2022.
//

import RxSwift
import NSObject_Rx
import UIKit

protocol Trackable {
    var loading: ActivityIndicator { get }
    var error: ErrorTracker { get }
}


class BaseViewModel {
//    var tracker: Trackable = Tracker()
    
    let loading = ActivityIndicator()
    let error = ErrorTracker()
    required init() {}
    deinit {
        print("\(type(of: self)): deinit")
    }
}

extension BaseViewModel: HasDisposeBag {}

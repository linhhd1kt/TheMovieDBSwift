//
//  ViewModel.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 22/09/2022.
//

import RxSwift
import NSObject_Rx

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

class BaseViewModel {

    /// 是否正在加载
    let loading = ActivityIndicator()
    /// track error
    let error = ErrorTracker()

    required init() {}

    deinit {
        print("\(type(of: self)): deinit")
    }
}

extension BaseViewModel: HasDisposeBag {}

//
//  DashboardViewModelType.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 10/10/2022.
//

import RxSwift

protocol DashboardViewModelType {
    var input: DashboardViewModelInputType { get }
    var output: DashboardViewModelOutputType { get }
}

protocol DashboardViewModelInputType {
    var viewDidLoad: AnyObserver<Void> { get }
}

protocol DashboardViewModelOutputType {
    var MoviesResult: Observable<[Movie]>  { get }
}

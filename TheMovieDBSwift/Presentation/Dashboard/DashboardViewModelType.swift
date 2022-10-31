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
    var fetchPopularMovies: AnyObserver<Int> { get }
}

protocol DashboardViewModelOutputType {
    var moviesResult: Observable<[Movie]> { get }
}

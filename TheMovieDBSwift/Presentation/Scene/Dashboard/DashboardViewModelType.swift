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
    var fetchDiscoverMovies: AnyObserver<(page: Int, category: DiscoverCategory)> { get }
    var fetchFreeWatchMovies: AnyObserver<(page: Int, category: DiscoverCategory)> { get }
    var fetchTrending: AnyObserver<(page: Int, category: DiscoverCategory)> { get }
}

protocol DashboardViewModelOutputType {
    var fetchPopularResult: Observable<MoviePage> { get }
    var fetchFreeWatchResult: Observable<MoviePage> { get }
    var fetchTrendingResult: Observable<MoviePage> { get }
}

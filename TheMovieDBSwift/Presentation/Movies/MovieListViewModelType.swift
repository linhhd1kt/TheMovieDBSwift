//
//  MovieListViewModelType.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 20/10/2022.
//

import RxSwift

protocol MovieListViewModelType {
    var input: MovieListViewModelInputType { get }
    var output: MovieListViewModelOutputType { get }
}

protocol MovieListViewModelInputType {
//    var reloadTrigger: AnyObserver<Void> { get }
    var nextPageTrigger: AnyObserver<Int> { get }
//    var movieSelected: AnyObserver<Movie?> { get }
}

protocol MovieListViewModelOutputType {
    var fetchMovieResult: Observable<MoviePage> { get }
//    var loading: Observable<Bool> { get }
}

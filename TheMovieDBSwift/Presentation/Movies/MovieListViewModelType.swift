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
    var fetchPopularMovies: AnyObserver<Int> { get }
    var movieSelected: AnyObserver<Movie?> { get }
}

protocol MovieListViewModelOutputType {
    var moviesResult: ActionResult<Page<Movie>> { get }
}

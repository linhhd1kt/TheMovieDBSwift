//
//  MovieUseCaseType.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 20/10/2022.
//

import RxSwift

protocol MovieUseCaseType {
    var input: MovieUseCaseInputType { get }
    var output: MovieUseCaseOutputType { get }
}

protocol MovieUseCaseInputType {
    var fetchPopular: AnyObserver<Int> { get }
    var fetchDicover: AnyObserver<Int> { get }
}

protocol MovieUseCaseOutputType {
    var fetchPopularResult: ActionResult<MoviePage> { get }
    var fetchDiscoverResult: ActionResult<MoviePage> { get }
}

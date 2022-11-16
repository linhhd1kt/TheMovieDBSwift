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
    var fetchPopular: AnyObserver<(page: Int, category: DiscoverCategory)> { get }
    var fetchFreeWatchMovie: AnyObserver<(page: Int, category: DiscoverCategory)> { get }
    var fetchFreeWatchTV: AnyObserver<(page: Int, category: DiscoverCategory)> { get }
    var fetchTrending: AnyObserver<(page: Int, mediaType: MediaType, timeWindow: TimeWindow)> { get }
}

protocol MovieUseCaseOutputType {
    var fetchPopularResult: ActionResult<MoviePage> { get }
    var fetchFreeWatchMovieResult: ActionResult<MoviePage> { get }
    var fetchFreeWatchTVResult: ActionResult<MoviePage> { get }
    var fetchTrendingResult: ActionResult<MoviePage> { get }
}

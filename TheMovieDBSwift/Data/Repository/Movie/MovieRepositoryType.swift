//
//  MovieRepositoryType.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 20/10/2022.
//

import Action

protocol MovieRepositoryType {
    var fetchPopularMovie: Action<PopularMovieRequest, MoviesResponse> { get }
    var fetchFreeWatchMovie: Action<FreeWatchMovieRequest, MoviesResponse> { get }
    var fetchFreeWatchTV: Action<FreeWatchTVRequest, MoviesResponse> { get }
    var fetchTrending: Action<TrendingRequest, MoviesResponse> { get }
}

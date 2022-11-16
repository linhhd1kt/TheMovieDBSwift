//
//  MovieRepository.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 20/10/2022.
//

import Action

class MovieRepository: MovieRepositoryType {
    let fetchPopularMovie: Action<PopularMovieRequest, MoviesResponse>
    var fetchFreeWatchMovie: Action<FreeWatchMovieRequest, MoviesResponse>
    var fetchFreeWatchTV: Action<FreeWatchTVRequest, MoviesResponse>
    var fetchTrending: Action<TrendingRequest, MoviesResponse>

    init(network: Networking = Network()) {
        fetchPopularMovie = Action { input in network.request(target: input.toTarget()) }
        fetchFreeWatchMovie = Action { input in network.request(target: input.toTarget()) }
        fetchFreeWatchTV = Action { input in network.request(target: input.toTarget()) }
        fetchTrending = Action { input in network.request(target: input.toTarget()) }
    }
}

extension MovieRepository: HasDisposeBag {}

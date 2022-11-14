//
//  MovieRepository.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 20/10/2022.
//

import Action

class MovieRepository: MovieRepositoryType {
    
    let fetchPopularMovie: Action<PopularMovieRequest, MoviesResponse>
    let fetchDiscoverMovie: Action<DiscoverMovieRequest, MoviesResponse>
    
    init(network: Networking = Network()) {
        fetchPopularMovie = Action { input in network.request(target: input.toTarget()) }
        fetchDiscoverMovie = Action { input in network.request(target: input.toTarget()) }
    }
}

extension MovieRepository: HasDisposeBag {}

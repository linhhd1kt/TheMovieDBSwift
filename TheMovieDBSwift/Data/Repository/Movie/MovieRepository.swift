//
//  MovieRepository.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 20/10/2022.
//

import Action
import RxSwift
import NSObject_Rx

class MovieRepository: MovieRepositoryType {
    
    let fetchPopular: Action<PopularMovieRequest, MoviesResponse>
    
    init(network: Networking = Network()) {
        fetchPopular = Action { input in network.request(target: input.toTarget()) }
    }
}

extension MovieRepository: HasDisposeBag {}

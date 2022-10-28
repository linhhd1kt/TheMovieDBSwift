//
//  MovieRepositoryType.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 20/10/2022.
//

import Action

protocol MovieRepositoryType {
    var fetchPopular: Action<PopularMovieRequest, MoviesResponse> { get }
}

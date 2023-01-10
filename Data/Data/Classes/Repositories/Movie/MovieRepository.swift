//
//  MovieRepository.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Action
import Services
import Extension

public protocol MovieRepositoryType {
  var fetchDiscoverMovie: Action<DiscoverMovieRequest, MovieResponse> { get }
  var fetchFreeWatchMovie: Action<FreeWatchMovieRequest, MovieResponse> { get }
  var fetchTrendingMovie: Action<TrendingMovieRequest, MovieResponse> { get }
}

public class MovieRepository: MovieRepositoryType {
  public let fetchDiscoverMovie: Action<DiscoverMovieRequest, MovieResponse>
  public var fetchFreeWatchMovie: Action<FreeWatchMovieRequest, MovieResponse>
  public var fetchTrendingMovie: Action<TrendingMovieRequest, MovieResponse>

  public init(network: Networking) {
    fetchDiscoverMovie = Action { input in
      network.request(target: input.toTarget(baseUrl: network.endPoint,
                                             apiKey: network.apiKey))
    }
    fetchFreeWatchMovie = Action { input in
      network.request(target: input.toTarget(baseUrl: network.endPoint,
                                             apiKey: network.apiKey))
    }
    fetchTrendingMovie = Action { input in
      network.request(target: input.toTarget(baseUrl: network.endPoint,
                                             apiKey: network.apiKey))
    }
  }
}

extension MovieRepository: HasDisposeBag {}

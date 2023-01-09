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
  var fetchPopularMovie: Action<PopularMovieRequest, MoviesResponse> { get }
  var fetchFreeWatchMovie: Action<FreeWatchMovieRequest, MoviesResponse> { get }
  var fetchFreeWatchTV: Action<FreeWatchTVRequest, MoviesResponse> { get }
  var fetchTrending: Action<TrendingRequest, MoviesResponse> { get }
}

public class MovieRepository: MovieRepositoryType {
  public let fetchPopularMovie: Action<PopularMovieRequest, MoviesResponse>
  public var fetchFreeWatchMovie: Action<FreeWatchMovieRequest, MoviesResponse>
  public var fetchFreeWatchTV: Action<FreeWatchTVRequest, MoviesResponse>
  public var fetchTrending: Action<TrendingRequest, MoviesResponse>

  public init(network: Networking) {
    fetchPopularMovie = Action { input in
      network.request(target: input.toTarget(baseUrl: network.endPoint, apiKey: network.apiKey))
    }
    fetchFreeWatchMovie = Action { input in
      network.request(target: input.toTarget(baseUrl: network.endPoint, apiKey: network.apiKey))
    }
    fetchFreeWatchTV = Action { input in
      network.request(target: input.toTarget(baseUrl: network.endPoint, apiKey: network.apiKey))
    }
    fetchTrending = Action { input in
      network.request(target: input.toTarget(baseUrl: network.endPoint, apiKey: network.apiKey))
    }
  }
}

extension MovieRepository: HasDisposeBag {}

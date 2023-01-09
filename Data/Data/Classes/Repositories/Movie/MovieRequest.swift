//
//  MovieRequest.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Moya
import Services

public struct PopularMovieRequest {
  public let page: Int
  public let monetization: MonetizationType
  public let releaseTypes: Set<ReleaseType>

  public init(page: Int, monetization: MonetizationType, releaseTypes: Set<ReleaseType>) {
    self.page = page
    self.monetization = monetization
    self.releaseTypes = releaseTypes
  }
}

extension PopularMovieRequest: ApiRequestType {
  public func toTarget(baseUrl: URL, apiKey: String) -> TargetType {
    return API(baseURL: baseUrl,
               target: .popularMovie(page: page),
               apiKey: apiKey)
  }
}

public struct FreeWatchMovieRequest {
  public let page: Int

  public init(page: Int) {
    self.page = page
  }
}

extension FreeWatchMovieRequest: ApiRequestType {
  public func toTarget(baseUrl: URL, apiKey: String) -> TargetType {
    return API(baseURL: baseUrl,
               target: .discoverMovie(page: page, monetization: .free, releaseTypes: []),
               apiKey: apiKey)
  }
}

public struct TrendingMovieRequest {
  public let page: Int
  public let mediaType: MediaType
  public let timeWindow: TimeWindow

  public init(page: Int, mediaType: MediaType, timeWindow: TimeWindow) {
    self.page = page
    self.mediaType = mediaType
    self.timeWindow = timeWindow
  }
}

extension TrendingMovieRequest: ApiRequestType {
  public func toTarget(baseUrl: URL, apiKey: String) -> TargetType {
    return API(baseURL: baseUrl,
               target: .trending(page: page, mediaType: .movie, timeWindow: timeWindow),
               apiKey: apiKey)
  }
}

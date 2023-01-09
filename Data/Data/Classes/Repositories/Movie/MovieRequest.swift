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
               target: .discoverTV(page: page,
                                   monetization: monetization),
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

public struct FreeWatchTVRequest {
  public let page: Int

  public init(page: Int) {
    self.page = page
  }
}

extension FreeWatchTVRequest: ApiRequestType {
  public func toTarget(baseUrl: URL, apiKey: String) -> TargetType {
    return API(baseURL: baseUrl,
               target: .discoverTV(page: page, monetization: .free),
               apiKey: apiKey)
  }
}

public struct TrendingRequest {
  public let page: Int
  public let mediaType: MediaType
  public let timeWindow: TimeWindow

  public init(page: Int, mediaType: MediaType, timeWindow: TimeWindow) {
    self.page = page
    self.mediaType = mediaType
    self.timeWindow = timeWindow
  }
}

extension TrendingRequest: ApiRequestType {
  public func toTarget(baseUrl: URL, apiKey: String) -> TargetType {
    return API(baseURL: baseUrl,
               target: .trending(page: page, mediaType: mediaType, timeWindow: timeWindow),
               apiKey: apiKey)
  }
}

public struct LatestTrailerOnTVRequest {
  public init() {}
}

extension LatestTrailerOnTVRequest: ApiRequestType {
  public func toTarget(baseUrl: URL, apiKey: String) -> TargetType {
    return API(baseURL: baseUrl,
               target: .latestTrailerOnTV,
               apiKey: apiKey)
  }
}

public struct LatestTrailerOnThreatersRequest {
  public init() {}
}

extension LatestTrailerOnThreatersRequest: ApiRequestType {
  public func toTarget(baseUrl: URL, apiKey: String) -> TargetType {
    return API(baseURL: baseUrl,
               target: .latestTrailerOnThreaters,
               apiKey: apiKey)
  }
}

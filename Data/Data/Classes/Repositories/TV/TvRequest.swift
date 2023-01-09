//
//  TvRequest.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Moya
import Services

public struct FreeWatchTvRequest {
  public let page: Int

  public init(page: Int) {
    self.page = page
  }
}

extension FreeWatchTvRequest: ApiRequestType {
  public func toTarget(baseUrl: URL, apiKey: String) -> TargetType {
    return API(baseURL: baseUrl,
               target: .discoverTv(page: page, monetization: .free, releaseTypes: []),
               apiKey: apiKey)
  }
}

public struct TrendingTvRequest {
  public let page: Int
  public let mediaType: MediaType
  public let timeWindow: TimeWindow

  public init(page: Int, mediaType: MediaType, timeWindow: TimeWindow) {
    self.page = page
    self.mediaType = mediaType
    self.timeWindow = timeWindow
  }
}

extension TrendingTvRequest: ApiRequestType {
  public func toTarget(baseUrl: URL, apiKey: String) -> TargetType {
    return API(baseURL: baseUrl,
               target: .trending(page: page, mediaType: .tv, timeWindow: timeWindow),
               apiKey: apiKey)
  }
}

public struct LatestTrailerOnTVRequest {
  public init() {}
}

extension LatestTrailerOnTVRequest: ApiRequestType {
  public func toTarget(baseUrl: URL, apiKey: String) -> TargetType {
    return API(baseURL: baseUrl,
               target: .latestTrailerOnTv,
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

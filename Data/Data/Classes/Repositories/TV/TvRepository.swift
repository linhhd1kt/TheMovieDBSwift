//
//  TvRepository.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Action
import Services
import Extension

public protocol TvRepositoryType {
  var fetchFreeWatchTv: Action<FreeWatchTvRequest, TvResponse> { get }
  var fetchTrendingTv: Action<TrendingTvRequest, TvResponse> { get }
}

public class TvRepository: TvRepositoryType {
  public var fetchFreeWatchTv: Action<FreeWatchTvRequest, TvResponse>
  public var fetchTrendingTv: Action<TrendingTvRequest, TvResponse>

  public init(network: Networking) {
    fetchFreeWatchTv = Action { input in
      network.request(target: input.toTarget(baseUrl: network.endPoint, apiKey: network.apiKey))
    }
    fetchTrendingTv = Action { input in
      network.request(target: input.toTarget(baseUrl: network.endPoint, apiKey: network.apiKey))
    }
  }
}

extension TvRepository: HasDisposeBag {}

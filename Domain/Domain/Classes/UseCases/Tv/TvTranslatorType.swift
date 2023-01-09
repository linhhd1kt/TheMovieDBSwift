//
//  TvTranslatorType.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Data

public protocol TvTranslatorType {
  func toFreeWatchTvRequest(page: Int) -> FreeWatchTvRequest
  func toTrendingTvRequest(timeWindow: TimeWindow) -> TrendingTvRequest
  func toModels(response: TvResponse) -> [Tv]
  func toModel(response: TvResponse.Data) -> Tv
  func toPage(response: TvResponse) -> TvPage
}

//
//  Round.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

public struct Round: Codable {
  let dayMonth, monthTime, monthType: Int
  let startTime, endTime, roundIndirect, outdirect: Bool

  enum CodingKeys: String, CodingKey {
    case dayMonth = "day_month"
    case monthTime = "month_time"
    case monthType = "month_type"
    case startTime = "start_time"
    case endTime = "end_time"
    case roundIndirect = "indirect"
    case outdirect
  }
}

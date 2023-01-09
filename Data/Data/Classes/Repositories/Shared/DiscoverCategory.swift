//
//  DiscoverCategory.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Foundation

public enum DiscoverCategory: String, CaseIterable {
  case streaming
  case onTV = "on_tv"
  case forRent = "for_rent"
  case onThreaters = "on_threaters"
  case movie
  case tv
  case day = "today"
  case week

  public var title: String {
    switch self {
    case .streaming:
      return "Streaming"
    case .onTV:
      return "On TV"
    case .forRent:
      return "For Rent"
    case .onThreaters:
      return "On Threaters"
    case .movie:
      return "Movie"
    case .tv:
      return "TV"
    case .day:
      return "Today"
    case .week:
      return "This Week"
    }
  }

  public static var popularItems: [DiscoverCategory] {
    return [.streaming, .onTV, .onThreaters, .forRent]
  }

  public static var freeItems: [DiscoverCategory] {
    return [.movie, .tv]
  }

  public static var treding: [DiscoverCategory] {
    return [.day, .week]
  }
}

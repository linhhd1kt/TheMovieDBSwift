//
//  MonetizationType.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

public enum MonetizationType {
  case flatrate
  case free
  case ads
  case rent
  case buy
  case none

  public var title: String {
    switch self {
    case .flatrate: return "In sThreaters"
    case .free: return "Free"
    case .ads: return "Ads"
    case .rent: return "For Rent"
    case .buy: return "Buy"
    case .none: return ""
    }
  }

  public var filterParameter: String? {
    switch self {
    case .flatrate: return "flatrate"
    case .free: return "free"
    case .ads: return "ads"
    case .rent: return "rent"
    case .buy: return "buy"
    case .none: return nil
    }
  }
}

//
//  MonetizationType.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 11/11/2022.
//

enum MonetizationType {
    case flatrate
    case free
    case ads
    case rent
    case buy
    case none
    
    var title: String {
        switch self {
        case .flatrate: return "In sThreaters"
        case .free: return "Free"
        case .ads: return "Ads"
        case .rent: return "For Rent"
        case .buy: return "Buy"
        case .none: return ""
        }
    }
    
    var filterParameter: String? {
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

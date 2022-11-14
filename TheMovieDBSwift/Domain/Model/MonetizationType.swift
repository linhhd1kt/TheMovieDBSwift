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
    
    var title: String {
        switch self {
        case .flatrate: return "In sThreaters"
        case .free: return "Free"
        case .ads: return "Ads"
        case .rent: return "For Rent"
        case .buy: return "Buy"
        }
    }
    
    var filterParameter: String {
        switch self {
        case .flatrate: return "flatrate"
        case .free: return "free"
        case .ads: return "ads"
        case .rent: return "rent"
        case .buy: return "buy"
        }
    }
}

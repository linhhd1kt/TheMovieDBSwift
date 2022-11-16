//
//  DiscoverCategory.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 11/11/2022.
//

import RxDataSources

struct CategorySession {
  var header: String
  var items: [Item]
}

extension CategorySession: SectionModelType {
  typealias Item = DiscoverCategory

   init(original: CategorySession, items: [Item]) {
    self = original
    self.items = items
  }
}

enum DiscoverCategory: String, CaseIterable {
    case streaming = "streaming"
    case onTV = "on_tv"
    case forRent = "for_rent"
    case onThreaters = "on_threaters"
    case movie = "movie"
    case tv = "tv"
    case day = "today"
    case week = "week"
    
    var title: String {
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
    
    static var popularItems: [DiscoverCategory] {
        return [.streaming, .onTV, .onThreaters, .forRent]
    }
    
    static var freeItems: [DiscoverCategory] {
        return [.movie, .tv]
    }
    static var treding: [DiscoverCategory] {
        return [.day, .week]
    }
}

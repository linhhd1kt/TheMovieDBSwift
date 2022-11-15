//
//  PopularCategory.swift
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
    case streaming = "Streaming"
    case onTV = "On TV"
    case forRent = "For Rent"
    case onThreaters = "On Threaters"
    case movie
    case TV
    
    var title: String {
        return self.rawValue
    }
    
    static var popularItems: [DiscoverCategory] {
        return [.streaming, .onTV, .onThreaters, .forRent]
    }
}

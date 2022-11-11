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
  typealias Item = PopularCategory

   init(original: CategorySession, items: [Item]) {
    self = original
    self.items = items
  }
}

enum PopularCategory: String, CaseIterable {
    case streaming = "Streaming"
    case onTV = "On TV"
    case forRent = "For Rent"
    case onThreaters = "On Threaters"
    
    var title: String {
        return self.rawValue
    }
}

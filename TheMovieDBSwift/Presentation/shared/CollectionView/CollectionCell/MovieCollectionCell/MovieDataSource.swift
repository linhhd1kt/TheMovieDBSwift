//
//  MovieDataSource.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 30/10/2022.
//

import RxDataSources
import CloudKit

struct ItemSession<Element> {
  var title: String
  var items: [Element]
}

extension ItemSession: SectionModelType {
  typealias Item = Element
    
    var identity: String {
        return title
    }

   init(original: ItemSession, items: [Item]) {
    self = original
    self.items = items
  }
}

//
//  MovieDataSource.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import RxDataSources

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

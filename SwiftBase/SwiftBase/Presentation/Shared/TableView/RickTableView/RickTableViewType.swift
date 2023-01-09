//
//  RickTableViewType.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Foundation
import RxSwift

protocol RickTableViewInputType {
  associatedtype Page
  var itemsResult: AnyObserver<Page> { get }
}

protocol RickTableViewOutputType {
  var nextPageTrigger: Observable<Int> { get }
}

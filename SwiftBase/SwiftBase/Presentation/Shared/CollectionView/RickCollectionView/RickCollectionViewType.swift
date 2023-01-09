//
//  RickCollectionViewType.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Foundation
import RxSwift

protocol RickCollectionViewInputType {
  associatedtype Page
  var itemsResult: AnyObserver<Page> { get }
  var reset: AnyObserver<Void> { get }
}

protocol RickCollectionViewOutputType {
  var nextPageTrigger: Observable<Int> { get }
}

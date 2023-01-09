//
//  HomeViewModelType.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import RxSwift

public protocol HomeViewModelType {
  var input: HomeViewModelInputType { get }
  var output: HomeViewModelOutputType { get }
}

public protocol HomeViewModelInputType {
  var shopListRequest: AnyObserver<Void> { get }
}

public protocol HomeViewModelOutputType {
  var shopListResult: Observable<String> { get }
}

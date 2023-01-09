//
//  NavigationViewModelType.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import RxSwift
import Domain
import Data

public protocol NavigationViewModelType {
  var input: NavigationViewModelInputType { get }
  var output: NavigationViewModelOutputType { get }
}

public protocol NavigationViewModelInputType {
  var navigationSelect: AnyObserver<Screen> { get }
}

public protocol NavigationViewModelOutputType {
  var navigationSelected: Observable<Screen> { get }
  var menuItems: Observable<[Screen]> { get }
}

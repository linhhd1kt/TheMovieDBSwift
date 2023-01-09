//
//  TabbarViewModelType.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import RxSwift

public protocol TabbarViewModelType {
  var input: TabbarViewModelInputType { get }
  var output: TabbarViewModelOutputType { get }
}

public protocol TabbarViewModelInputType {}

public protocol TabbarViewModelOutputType {}

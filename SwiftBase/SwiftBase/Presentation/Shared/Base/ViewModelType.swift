//
//  ViewModelType.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Foundation

public protocol ViewModelType {
  associatedtype InputType
  associatedtype OutputType
  func transform(input: InputType) -> OutputType
}

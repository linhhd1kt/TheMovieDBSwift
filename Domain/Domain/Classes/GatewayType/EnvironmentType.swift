//
//  EnvironmentType.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Foundation

public protocol EnvironmentType {
  var baseUrl: URL { get }
  var baseImageUrl: URL { get }
  var privacyUrl: URL { get }
  var contactUrl: URL { get }
  var termsUrl: URL { get }
  var apiKey: String { get }
}

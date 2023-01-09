//
//  Duration.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Foundation

// https://m3.material.io/styles/motion/easing-and-duration/tokens-specs

public protocol DurationType {
  var short1: Int { get }
  var short2: Int { get }
  var short3: Int { get }
  var short4: Int { get }
  var medium1: Int { get }
  var medium2: Int { get }
  var medium3: Int { get }
  var medium4: Int { get }
  var long1: Int { get }
  var long2: Int { get }
  var long3: Int { get }
  var long4: Int { get }
  var extraLong1: Int { get }
  var extraLong2: Int { get }
  var extraLong3: Int { get }
  var extraLong4: Int { get }
}

public struct DefaultDuration: DurationType {
  public let short1 = 50
  public let short2 = 100
  public let short3 = 150
  public let short4 = 200
  public let medium1 = 250
  public let medium2 = 300
  public let medium3 = 350
  public let medium4 = 400
  public let long1 = 450
  public let long2 = 500
  public let long3 = 550
  public let long4 = 600
  public let extraLong1 = 700
  public let extraLong2 = 800
  public let extraLong3 = 900
  public let extraLong4 = 1000
}

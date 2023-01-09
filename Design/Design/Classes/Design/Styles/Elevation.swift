//
//  Elevation.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

public protocol ElevationType {
  var level0: Int { get }
  var level1: Int { get }
  var level2: Int { get }
  var level3: Int { get }
  var level4: Int { get }
  var level5: Int { get }
}

public struct DefaultElevation: ElevationType {
  public let level0 = 0
  public let level1 = 1
  public let level2 = 2
  public let level3 = 3
  public let level4 = 4
  public let level5 = 5
}

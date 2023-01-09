//
//  Easing.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

// https://m3.material.io/styles/motion/easing-and-duration/applying-easing-and-duration
// https://m3.material.io/styles/motion/easing-and-duration/tokens-specs

public typealias EasingValue = (Float, Float, Float, Float)

public protocol EasingType {
  var linear: EasingValue { get }
  var standard: EasingValue { get }
  var standardAccelerate: EasingValue { get }
  var standardDecelerate: EasingValue { get }
  var emphasized: EasingValue { get }
  var emphasizedDecelerate: EasingValue { get }
  var emphasizedAccelerate: EasingValue { get }
  var legacy: EasingValue { get }
  var legacyDecelerate: EasingValue { get }
  var legacyAccelerate: EasingValue { get }
}

public struct DefaultEasing: EasingType {
  public let linear: EasingValue = (0, 0, 1, 1)
  public let standard: EasingValue = (0.2, 0, 0, 1)
  public let standardAccelerate: EasingValue = (0.3, 0, 1, 1)
  public let standardDecelerate: EasingValue = (0, 0, 0, 1)
  public let emphasized: EasingValue = (0.2, 0, 0, 1)
  public let emphasizedDecelerate: EasingValue = (0.05, 0.7, 0.1, 1)
  public let emphasizedAccelerate: EasingValue = (0.3, 0, 0.8, 0.15)
  public let legacy: EasingValue = (0.4, 0, 0.2, 1)
  public let legacyDecelerate: EasingValue = (0.0, 0, 0.2, 1)
  public let legacyAccelerate: EasingValue = (0.4, 0, 1.0, 1)
}

//
//  Shape.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

public enum ShapFamily {
  case rounded
  case cut
}

public typealias ShapScaleValue = (CGFloat, CGFloat, CGFloat, CGFloat)

public protocol ShapScaleType {
  var none: ShapScaleValue { get }
  var extraSmall: ShapScaleValue { get }
  var small: ShapScaleValue { get }
  var medium: ShapScaleValue { get }
  var large: ShapScaleValue { get }
  var extraLarge: ShapScaleValue { get }
  var full: ShapScaleValue { get }
}

public struct PaceBoxShapScale: ShapScaleType {
  public let none: ShapScaleValue = (0, 0, 0, 0)
  public let extraSmall: ShapScaleValue = (4, 4, 4, 4)
  public let small: ShapScaleValue = (8, 8, 8, 8)
  public let medium: ShapScaleValue = (12, 12, 12, 12)
  public let large: ShapScaleValue = (16, 16, 16, 16)
  public let extraLarge: ShapScaleValue = (28, 28, 28, 28)
  public let full: ShapScaleValue = (23, 23, 23, 23)
}

public protocol ShapType {
  var family: ShapFamily { get }
  var scale: ShapScaleType { get }
}

public struct DefaultShap: ShapType {
  public let family: ShapFamily = .rounded
  public let scale: ShapScaleType = PaceBoxShapScale()
}

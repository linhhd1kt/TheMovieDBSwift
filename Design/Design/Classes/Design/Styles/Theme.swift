//
//  Theme.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import UIKit

// https://www.figma.com/community/file/1035203688168086460
// https://github.com/material-foundation/material-color-utilities
// https://www.figma.com/community/plugin/1034969338659738588/Material-Theme-Builder
// https://m3.material.io/theme-builder#/custom
public protocol StyleType {
  var colors: ColorSystemType { get }
  var icons: IconsType { get }
  var elvation: ElevationType { get }
  var shap: ShapType { get }
  var easing: EasingType { get }
  var duration: DurationType { get }
  var symmetry: SymmetryType { get }
}

public struct LightStyle: StyleType {
  public let colors: ColorSystemType = LightColor()
  public let icons: IconsType = LightIcons()
  public let elvation: ElevationType = DefaultElevation()
  public let shap: ShapType = DefaultShap()
  public let easing: EasingType = DefaultEasing()
  public let duration: DurationType = DefaultDuration()
  public let symmetry: SymmetryType = .extraLargeTop
}

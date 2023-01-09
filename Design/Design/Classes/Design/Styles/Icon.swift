//
//  Icon.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import UIKit

// https://fonts.google.com/icons?icon.category=Privacy%26Security

public enum IconOpticalSize: Float {
  case tiny = 20.0
  case small = 24.0
  case medium = 40.0
  case large = 48.0
}

public enum IconWeith {
  case x100
  case x200
  case x300
  case x400
  case x500
  case x600
  case x700
  case x800
  case x900
}

public enum IconFill {
  case on
  case off
}

public enum IconGrade {
  case dark
  case normal
  case emphasis
}

public protocol IconType {
  var opticalSize: IconOpticalSize { get }
  var symbol: UIImage { get }
  var grade: IconGrade { get }
  var fill: IconFill { get }
}

public struct Icon: IconType {
  public let symbol: UIImage
  public let opticalSize: IconOpticalSize
  public let grade: IconGrade
  public let fill: IconFill

  init(_ symbol: UIImage?,
       opticalSize: IconOpticalSize = .small,
       grade: IconGrade = .normal,
       fill: IconFill = .off) {
    self.symbol = symbol ?? UIImage()
    self.opticalSize = opticalSize
    self.grade = grade
    self.fill = fill
  }
}

public protocol IconsType {
  var logo: IconType { get }
  var menu: IconType { get }
  var profile: IconType { get }
  var search: IconType { get }
}

public struct LightIcons: IconsType {
  public let logo: IconType = Icon(.init(named: "ic-logo"))
  public let menu: IconType = Icon(.init(named: "ic-menu"))
  public let profile: IconType = Icon(.init(named: "ic-profile"))
  public let search: IconType = Icon(.init(named: "ic-search"))
}

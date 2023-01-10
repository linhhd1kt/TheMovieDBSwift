//
//  Design.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import ObjectiveC
import UIKit

public protocol DesignType {
  var style: StyleType { get }
  func toggleTheme()
  func initialized()
}

open class DefautDesign: DesignType {
  public let style: StyleType = LightStyle()
  var userInterFaceStyle: UIUserInterfaceStyle = .light

  public init() {}

  open func initialized() {
    UIFont.overrideDefaultTypography()
    setTheme(.light)
  }

  open func toggleTheme() {
    var interfaceStyle: UIUserInterfaceStyle
    switch userInterFaceStyle {
    case .unspecified:
      interfaceStyle = .light
    case .light:
      interfaceStyle = .dark
    case .dark:
      interfaceStyle = .light
    @unknown default:
      interfaceStyle = .light
    }
    setTheme(interfaceStyle)
  }

  open func setTheme(_ style: UIUserInterfaceStyle) {
    userInterFaceStyle = style
    let scenes = UIApplication.shared.connectedScenes
    let windowScenes = scenes.first as? UIWindowScene
    let window = windowScenes?.windows.first
    window?.overrideUserInterfaceStyle = style
  }
}

private var designContext: UInt8 = 1

public protocol HasDeSign: AnyObject {
  var design: DesignType { get set }
}

public extension HasDeSign {
  // swiftlint:disable type_contents_order
  func synchronizedDesign<T>(_ action: () -> T) -> T {
    objc_sync_enter(self)
    let result = action()
    objc_sync_exit(self)
    return result
  }

  var design: DesignType {
    get {
      return synchronizedDesign {
        if let designObject = objc_getAssociatedObject(self, &designContext) as? DesignType {
          return designObject
        }
        let designObject = DefautDesign()
        objc_setAssociatedObject(self, &designContext, designObject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return designObject
      }
    }

    set {
      synchronizedDesign {
        objc_setAssociatedObject(self, &designContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      }
    }
  }
}

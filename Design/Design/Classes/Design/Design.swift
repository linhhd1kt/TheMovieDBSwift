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
  var userInterFaceStyle: UIUserInterfaceStyle { get }
  func toggleTheme()
  func initialized()
}

open class DefautDesign: DesignType {
  public let style: StyleType = LightStyle()
  public var userInterFaceStyle: UIUserInterfaceStyle = .light

  public init() {}

  open func initialized() {
    UIFont.overrideDefaultTypography()
    let isDarkInterface = UserDefaults.standard.bool(forKey: "theme")
    if isDarkInterface {
      setTheme(.dark)
    } else {
      setTheme(.light)
    }
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
    windowScenes?.windows.first?.overrideUserInterfaceStyle = style
    let isDarkInterface = style == .dark
    UserDefaults.standard.set(isDarkInterface, forKey: "theme")
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

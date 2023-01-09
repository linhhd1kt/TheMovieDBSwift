//
//  UIViewController+Ex.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import UIKit

public extension UIViewController {
  var moduleName: String {
    let object = NSStringFromClass(classForCoder) as NSString
    guard let moduleName = object.components(separatedBy: ".").first else {
      fatalError("Could not get module name")
    }
    return moduleName
  }

  var topMostViewController: UIViewController? {
    if presentedViewController == nil {
      return self
    }
    if let navigation = presentedViewController as? UINavigationController {
      return navigation.visibleViewController?.topMostViewController
    }
    if let tab = presentedViewController as? UITabBarController {
      if let selectedTab = tab.selectedViewController {
        return selectedTab.topMostViewController
      }
      return tab.topMostViewController
    }
    return presentedViewController?.topMostViewController
  }

  static func loadFromNib() -> Self {
    func instantiateFromNib<T: UIViewController>() -> T {
      return T(nibName: String(describing: T.self), bundle: nil)
    }
    return instantiateFromNib()
  }
}

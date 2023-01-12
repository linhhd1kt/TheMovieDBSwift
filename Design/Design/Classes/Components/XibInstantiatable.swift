//
//  XibInstantiatable.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import UIKit

public protocol XibInstantiatable {}

extension UIView: XibInstantiatable {}

public extension XibInstantiatable where Self: UIView {
  var moduleName: String {
    let object = NSStringFromClass(classForCoder) as NSString
    guard let moduleName = object.components(separatedBy: ".").first else {
      fatalError("Could not get module name")
    }
    return moduleName
  }

  static func instantiateFromXib(xibName: String = Self.className) -> Self {
    let bundle = Bundle(for: self)
    let xib = UINib(nibName: xibName, bundle: bundle)
    guard let view = xib.instantiate(withOwner: self, options: nil).first as? Self else {
      fatalError("UIView could not create.")
    }
    return view
  }

  func loadFromXib(xibName _: String = Self.className, moduleName: String? = nil) {
    var nib: UINib
    if let moduleName = moduleName {      
      let podBundle = Bundle(for: classForCoder)
      guard let bundleURL = podBundle.url(forResource: moduleName, withExtension: "bundle") else {
        fatalError("Cound not get bundle url from \(moduleName)!")
      }
      guard let bundle = Bundle(url: bundleURL) else {
        fatalError("Could not initial bundle from \(bundleURL)")
      }
      nib = UINib(nibName: className, bundle: bundle)
    } else {
      nib = UINib(nibName: className, bundle: nil)
    }
    
    guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {
      fatalError("Could not load view from class \(className)")
    }
    
    attach(view)
  }
}

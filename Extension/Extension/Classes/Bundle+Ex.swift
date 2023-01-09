//
//  Bundle+Ex.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Foundation

var _bundle: UInt8 = 0

class BundleEx: Bundle {
  override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
    let bundle: Bundle? = objc_getAssociatedObject(self, &_bundle) as? Bundle

    if let temp = bundle {
      return temp.localizedString(forKey: key, value: value, table: tableName)
    } else {
      return super.localizedString(forKey: key, value: value, table: tableName)
    }
  }
}

public extension Bundle {
  class func setLanguage(_ language: String?) {
    let oneToken = "pods.utility.kit"

    DispatchQueue.once(token: oneToken) {
      object_setClass(Bundle.main, BundleEx.self as AnyClass)
    }

    if let temp = language {
      guard let path = Bundle.main.path(forResource: temp, ofType: "lproj") else {
        fatalError("Bundle for language should not be nil")
      }
      objc_setAssociatedObject(Bundle.main, &_bundle, Bundle(path: path), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    } else {
      objc_setAssociatedObject(Bundle.main, &_bundle, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
}

extension DispatchQueue {
  private static var _onceTracker = [String]()

  class func once(token: String, block: () -> Void) {
    objc_sync_enter(self); defer { objc_sync_exit(self) }

    if _onceTracker.contains(token) {
      return
    }

    _onceTracker.append(token)
    block()
  }
}

extension Bundle {
  static func swizzleLocalization() {
    let orginalSelector = #selector(localizedString(forKey:value:table:))
    guard let orginalMethod = class_getInstanceMethod(self, orginalSelector) else {
      return
    }

    let mySelector = #selector(myLocaLizedString(forKey:value:table:))
    guard let myMethod = class_getInstanceMethod(self, mySelector) else {
      return
    }

    if class_addMethod(self, orginalSelector, method_getImplementation(myMethod), method_getTypeEncoding(myMethod)) {
      class_replaceMethod(self, mySelector, method_getImplementation(orginalMethod), method_getTypeEncoding(orginalMethod))
    } else {
      method_exchangeImplementations(orginalMethod, myMethod)
    }
  }

  @objc private func myLocaLizedString(forKey key: String,
                                       value: String?,
                                       table: String?) -> String {
    return Bundle.main.myLocaLizedString(forKey: key, value: value, table: table)
  }
}

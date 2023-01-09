//
//  UserDefault.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import RxSwift
import Services

public protocol UserDefaultType: AnyObject {
  var requestTokenId: String? { get set }
  var userInterfaceStyle: UIUserInterfaceStyle { get set }
}

public class UserDefault {
  fileprivate enum Key: String {
    case requestTokenId = "userdefault.request_token_id"
    case userInterfaceStyle = "userdefault.user_interface_style"
  }  
  fileprivate let `defaults` = UserDefaults.standard

  public init() {}
}

extension UserDefault: UserDefaultType {
  public var requestTokenId: String? {
    get {
      return defaults.string(forKey: Key.requestTokenId.rawValue)
    }
    set {
      defaults.setValue(newValue, forKey: Key.requestTokenId.rawValue)
      defaults.synchronize()
    }
  }

  public var userInterfaceStyle: UIUserInterfaceStyle {
    get {
      let value = defaults.integer(forKey: Key.userInterfaceStyle.rawValue)
      if value == 0 {
        return .light
      }
      let style = UIUserInterfaceStyle(rawValue: value) ?? .light
      return style
    }
    set {
      defaults.setValue(newValue.rawValue, forKey: Key.userInterfaceStyle.rawValue)
      defaults.synchronize()
    }
  }
}

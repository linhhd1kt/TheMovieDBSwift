//
//  Preferences.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 29/09/2022.
//

import Foundation
import RxSwift

protocol PreferencesStorable: AnyObject {
    var requestTokenId: String? { get set }
    var userInterfaceStyle: UIUserInterfaceStyle { get set }
}

class Preferences {
    fileprivate enum Key: String {
        case requestTokenId = "user.preferences.request_token_id"
        case userInterfaceStyle = "user.preferences.user_interface_style"
    }
    fileprivate let defaults = UserDefaults.standard
}

extension Preferences: PreferencesStorable {
    var requestTokenId: String? {
        get {
            return defaults.string(forKey: Key.requestTokenId.rawValue)
        }
        set {
            defaults.setValue(newValue, forKey: Key.requestTokenId.rawValue)
            defaults.synchronize()
        }
    }
    
    var userInterfaceStyle: UIUserInterfaceStyle {
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

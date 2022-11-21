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
        }
    }
    
    var userInterfaceStyle: UIUserInterfaceStyle {
        get {
            let value = defaults.integer(forKey: Key.userInterfaceStyle.rawValue)
            return UIUserInterfaceStyle(rawValue: value) ?? .unspecified
        }
        set {
            defaults.setValue(newValue.rawValue, forKey: Key.userInterfaceStyle.rawValue)
        }
    }
}

//
//  UserPreferencesStorage.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 29/09/2022.
//

import Foundation
import RxSwift

enum UserPreferencesKey: String {
    case requestTokenId = "user.preferences.request_token_id"
}

protocol UserPreferencesStorable {
    func value<T>(for key: String) -> T?
    func value<T>(for key: String) -> Observable<T?>
    func set(_ value: Any?, for key: String) -> Void
    func set(_ value: Any?, for key: String) -> Observable<Void>
}

class UserPreferencesStorage: UserPreferencesStorable {
    
    
    func value<T>(for key: String) -> T? {
        return UserDefaults.standard.value(forKey: key) as? T
    }
    
    func value<T>(for key: String) -> Observable<T?> {
        return Observable<T?>.create { observer in
            let value = UserDefaults.standard.value(forKey: key) as? T
            observer.onNext(value)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func set(_ value: Any?, for key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func set(_ value: Any?, for key: String) -> Observable<Void> {
        return Observable<Void>.create { observer in
            UserDefaults.standard.set(value, forKey: key)
            UserDefaults.standard.synchronize()
            observer.onNext(())
            observer.onCompleted()
            return Disposables.create()
        }
    }
}

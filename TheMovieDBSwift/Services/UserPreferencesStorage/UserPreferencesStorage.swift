//
//  UserPreferencesStorage.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 29/09/2022.
//

import Foundation
import RxSwift

protocol UserPreferencesStorable {
    func value<T>(forKey key: String) -> Observable<T?>
    func set(_ value: Any?, forKey defaultName: String) -> Observable<Void>
}

class UserPreferencesStorage: UserPreferencesStorable {
    
    func value<T>(forKey key: String) -> Observable<T?> {
        return Observable.create { observer in
            observer.onNext(UserDefaults.standard.value(forKey: key) as? T)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func set(_ value: Any?, forKey defaultName: String) -> Observable<Void> {
        return Observable.create { observer in
            UserDefaults.standard.set(value, forKey: defaultName)
            observer.onNext(())
            observer.onCompleted()
            return Disposables.create()
        }
    }
}

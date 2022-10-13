//
//  RxSwift+Ex.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 09/09/2022.
//

import Foundation
import RxSwift

struct MapFromNever: Error {}

extension ObservableType where Element == Void {
    func map<T>(to: T.Type) -> Observable<T> {
        return self.flatMap { _ in
            return Observable<T>.error(MapFromNever())
        }
    }
}
extension ObservableType where Element: OptionalType {
    func filterNil() -> Observable<Element.Wrapped> {
        return flatMap { element -> Observable<Element.Wrapped> in
            guard let value = element.value else {
                return Observable<Element.Wrapped>.empty()
            }
            return Observable<Element.Wrapped>.just(value)
        }
    }
}

extension ObservableType where Element == Any {
    static func combineLatestAll(_ o1: Observable<Bool>, _ o2: Observable<Bool>) -> Observable<Bool> {
        return Observable.combineLatest(o1, o2) { $0 && $1 }
    }
    static func combineLatestAll(_ o1: Observable<Bool>, _ o2: Observable<Bool>, _ o3: Observable<Bool>) -> Observable<Bool> {
        return Observable.combineLatest(o1, o2, o3) { $0 && $1 && $2 }
    }
    static func combineLatestAll(_ o1: Observable<Bool>, _ o2: Observable<Bool>, _ o3: Observable<Bool>, _ o4: Observable<Bool>) -> Observable<Bool> {
        return Observable.combineLatest(o1, o2, o3, o4) { $0 && $1 && $2 && $3 }
    }
    static func combineLatestAny(_ o1: Observable<Bool>, _ o2: Observable<Bool>) -> Observable<Bool> {
        return Observable.combineLatest(o1, o2) { $0 || $1 }
    }
    static func combineLatestAny(_ o1: Observable<Bool>, _ o2: Observable<Bool>, _ o3: Observable<Bool>) -> Observable<Bool> {
        return Observable.combineLatest(o1, o2, o3) { $0 || $1 || $2 }
    }
    static func combineLatestAny(_ o1: Observable<Bool>, _ o2: Observable<Bool>, _ o3: Observable<Bool>, _ o4: Observable<Bool>) -> Observable<Bool> {
        return Observable.combineLatest(o1, o2, o3, o4) { $0 || $1 || $2 || $3 }
    }
    static func combineLatestAny(_ o1: Observable<Bool>, _ o2: Observable<Bool>, _ o3: Observable<Bool>, _ o4: Observable<Bool>, _ o5: Observable<Bool>) -> Observable<Bool> {
        return Observable.combineLatest(o1, o2, o3, o4, o5) { $0 || $1 || $2 || $3 || $4 }
    }
}


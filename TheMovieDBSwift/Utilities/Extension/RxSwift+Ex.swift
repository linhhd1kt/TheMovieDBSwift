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

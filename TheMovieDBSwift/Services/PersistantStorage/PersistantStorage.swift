//
//  PersistantStorage.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 09/09/2022.
//

import Foundation
import RxSwift
import Realm
import RealmSwift

protocol PersistantStorable {
    func get<T: Object>(id: String) -> Observable<T?>
    func save<T: Object>(entity: T) -> Observable<Void>
    func getAll<T: Object>() -> Observable<[T]>
    func update<T: Object>(entity: T) -> Observable<Void>
    func delete<T: Object>(id: String, ofType: T.Type) -> Observable<Void>
}

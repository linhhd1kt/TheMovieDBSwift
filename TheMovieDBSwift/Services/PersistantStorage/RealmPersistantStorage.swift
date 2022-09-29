//
//  RealmPersistantStorage.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 29/08/2022.
//

import Foundation
import Realm
import RealmSwift
import RxSwift
import RxRealm

final class RealmPersistantStorage: PersistantStorable {
    private let configuration: Realm.Configuration    
    private var realm: Realm {
        guard let realm = try? Realm(configuration: configuration) else {
            fatalError("-: Error from confgure realm service please recheck configure or migration realm :-")
        }
        return realm
    }
    private let scheduler: SchedulerType
    
    init(configuration: Realm.Configuration = Realm.Configuration.defaultConfiguration,
         scheduler: SchedulerType = SerialDispatchQueueScheduler.init(qos: .utility)) {
        self.configuration = configuration
        self.scheduler = scheduler
    }
    func get<T: Object>(id: String) -> Observable<T?> {
        return Observable.deferred {
            return Observable.just(self.realm.object(ofType: T.self, forPrimaryKey: id))
        }.subscribe(on: scheduler)
    }
    
    func save<T: Object>(entity: T) -> Observable<Void> {
        return Observable<Void>.create { observer in
            do {
                try self.realm.write {
                    self.realm.add(entity)
                }
                observer.onNext(())
                observer.onCompleted()
            } catch {                
                observer.onError(LocalError.some(description: error.localizedDescription))
            }
            return Disposables.create()
        }.subscribe(on: scheduler)
    }

    func getAll<T: Object>() -> Observable<[T]> {
        return Observable.deferred {
            return Observable.just(self.realm.objects(T.self).toArray())
        }.subscribe(on: scheduler)
    }
    
    func update<T: Object>(entity: T) -> Observable<Void> {
        return Observable.deferred {
            return Observable.just(self.realm.add(entity, update: .all))
        }.subscribe(on: scheduler)
    }
    
    func delete<T: Object>(id: String, ofType: T.Type) -> Observable<Void> {
        return Observable.create { observer in
            do {
                try self.realm.write {
                    guard let object = self.realm.object(ofType: T.self, forPrimaryKey: id) else {
                        observer.onNext(())
                        observer.onCompleted()
                        return
                    }
                    self.realm.delete(object)
                }
                observer.onNext(())
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }.subscribe(on: scheduler)
    }
}


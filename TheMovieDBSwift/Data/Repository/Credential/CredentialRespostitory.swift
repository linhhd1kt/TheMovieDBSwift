//
//  CredentialRespostitory.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 29/08/2022.
//

import Foundation
import RxSwift
import Alamofire
import NSObject_Rx
import RealmSwift

class CredentialRespository<L, R>: Respository
where L: DataSource, L.T == CredentialObject, R: DataSource, R.T == CredentialObject {
    let localDataSource: L
    let remoteDataSource: R
    
    var userPreferencesStorage: UserPreferencesStorable {
        guard let preferences = ServiceFacade.getService(UserPreferencesStorable.self) else {
            preconditionFailure("User Preferences Storage service not registered!")
        }
        return preferences
    }
    
    var logger: Logable {
        guard let logger = ServiceFacade.getService(Logable.self) else {
            preconditionFailure("Logger service not registered!")
        }
        return logger
    }

    init(localDataSource: L, remoteDataSource: R) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }
    
    func get(id: String?, parameters: [String: Any]) -> Observable<CredentialObject?> {
        
        // get saved credential in user preferences for username
        let getSavedCredentialId: Observable<String?> = Observable.just(id)
            .compactMap { $0 }
            .withUnretained(self)
            .flatMapLatest { this, id in
                this.userPreferencesStorage.valueObservable(for: id)
            }
            .debug("CredentialRespository get saved credential id from user preferences")
        
        let localData: Observable<CredentialObject?> = getSavedCredentialId
            .withUnretained(self)
            .flatMapLatest { this, id in
                this.localDataSource.get(id: id, parameters: parameters)
            }
            .debug("CredentialRespository get local data from LocalDataSource")

        let remoteData: Observable<CredentialObject?> = remoteDataSource
            .get(id: id, parameters: parameters)
            .share()
        
        // save credential id to user preferences
        Observable.combineLatest(remoteData.compactMap { $0 }.map { $0.requestToken },
                                 Observable.just(id).compactMap { $0 })
            .withUnretained(self)
            .flatMapLatest { this, info in
                return this.userPreferencesStorage.setObservable(info.0, for: info.1)
            }
            .subscribe()
            .disposed(by: disposeBag)
        
        remoteData.compactMap { $0 }
            .withUnretained(self)
            .flatMapLatest { this, credential in
                return this.localDataSource.save(entity: credential)
            }
            .subscribe()
            .disposed(by: disposeBag)

        return localData.concat(remoteData)
    }
    
    func save(entity: CredentialObject) -> Observable<Void> {
        return localDataSource.save(entity: entity)
    }
}

extension CredentialRespository: HasDisposeBag {}

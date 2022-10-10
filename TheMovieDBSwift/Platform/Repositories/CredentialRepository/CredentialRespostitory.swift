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
where L: DataSource, L.T == Credential, R: DataSource, R.T == Credential {
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
    
    func get(id: String?, parameters: Dictionary<String, Any>) -> Observable<Credential?> {
        
        // get saved credential in user preferences for username
        let getSavedCredentialId: Observable<String?> = Observable.just(id)
            .compactMap { $0 }
            .flatMapLatest { [unowned self] id in
                self.userPreferencesStorage.value(for: id)
            }
            .debug("CredentialRespository get saved credential id from user preferences")
        
        let localData: Observable<Credential?> = getSavedCredentialId
            .flatMapLatest { [unowned self] in
                self.localDataSource
                    .get(id: $0, parameters: parameters)
            }
            .debug("CredentialRespository get local data from LocalDataSource")

        let remoteData: Observable<Credential?> = remoteDataSource
            .get(id: id, parameters: parameters)
            .share()
            .debug("CredentialRespository RemoteDataSource get")
        
        // save credential id to user preferences
        Observable.combineLatest(remoteData.compactMap { $0 }.map { $0.requestToken },
                                 Observable.just(id).compactMap { $0 })
            .debug("CredentialRespository save request token id")
            .flatMapLatest { [unowned self] in
                self.userPreferencesStorage.set($0 ,for: $1)
            }
            .subscribe()
            .disposed(by: disposeBag)
        
        remoteData.compactMap { $0 }
            .debug("CredentialRespository RemoteDataSource save remote data to local")
            .flatMapLatest { [unowned self] in
                self.localDataSource.save(entity: $0)
                    .debug("CredentialRespository LocalDataSource save")
            }
            .subscribe()
            .disposed(by: disposeBag)

        return localData.concat(remoteData)
    }
    
    func save(entity: Credential) -> Observable<Void> {
        return localDataSource.save(entity: entity)
    }
}

extension CredentialRespository: HasDisposeBag {}

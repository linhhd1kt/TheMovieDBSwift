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


class CredentialRespository<L, R>: Respository where L: DataSource, L.T == Credential,
                                                    R: DataSource, R.T == Credential {
    let localDataSource: L
    let remoteDataSource: R

    init(localDataSource: L, remoteDataSource: R) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }
    
    func get(id: String?, parameters: Dictionary<String, Any>) -> Observable<Credential?> {
        let localData: Observable<Credential?> = localDataSource
            .get(id: id, parameters: parameters)
            .debug("CredentialDataRepository get local data")
        
        let remoteData: Observable<Credential?> = remoteDataSource
            .get(id: id, parameters: parameters)
            .share()
            .debug("CredentialDataRepository get remote data")
        
        remoteData.compactMap { $0 }
            .debug("CredentialDataRepository save remote data to local")
            .flatMapLatest { [unowned self] in
                self.localDataSource.save(entity: $0)
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

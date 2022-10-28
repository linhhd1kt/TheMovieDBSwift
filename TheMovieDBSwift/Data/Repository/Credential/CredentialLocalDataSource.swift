//
//  CredentialLocalDataSource.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 29/08/2022.
//

import Foundation
import RxSwift

final class CredentialLocalDataSource: DataSource {
    typealias T = CredentialObject
    var localStorage: PersistantStorable {
        guard let storage = ServiceFacade.getService(PersistantStorable.self) else {
            fatalError("Persistant Storage should be implementaion!")
        }
        return storage
    }
        
    func get(id: String?, parameters paramters: [String: Any]) -> Observable<T?> {
        guard let id = id else {
            preconditionFailure("Parameter must have id to get value!")
        }
        return localStorage.get(id: id)
    }
    
    func save(entity: T) -> Observable<Void> {
        return localStorage.save(entity: entity)
    }
}

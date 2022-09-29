//
//  CredentialLocalDataSource.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 29/08/2022.
//

import Foundation
import RxSwift

//protocol CredentialRepository {
//    func get(id: String?, parameters: Dictionary<String, Any>) -> Observable<Credential?>
//    func save(entity: Credential) -> Observable<Void>
//}


protocol Respository {
    associatedtype T: Decodable & Identifiable
    func get(id: String?, parameters: Dictionary<String, Any>) -> Observable<T?>
    func save(entity: T) -> Observable<Void>
}

final class CredentialLocalDataSource: DataSource {
    typealias T = Credential
    var localStorage: PersistantStorable {
        guard let storage = ServiceFacade.getService(PersistantStorable.self) else {
            fatalError("Persistant Storage should be implementaion!")
        }
        return storage
    }
        
    func get(id: String?, parameters paramters: Dictionary<String,Any>) -> Observable<T?> {
        guard let id = id else {
            preconditionFailure("Parameter must have id to get value!")
        }
        return localStorage.get(id: id)
    }
    
    func save(entity: T) -> Observable<Void> {
        return localStorage.save(entity: entity)
    }
}

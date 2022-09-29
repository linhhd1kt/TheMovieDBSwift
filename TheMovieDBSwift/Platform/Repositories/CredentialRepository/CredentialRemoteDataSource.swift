//
//  CredentialRemoteDataSource.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 29/08/2022.
//

import Foundation
import RxSwift

final class CredentialRemoteDataSource: DataSource {
    typealias T = Credential
    var network: Networking {
        guard let network = ServiceFacade.getService(Networking.self) else {
            preconditionFailure("Networking service not registered!")
        }
        return network
    }
    
    func get(id: String?, parameters: Dictionary<String, Any>) -> Observable<T?> {
        
        return network.request(target: API.createSessionWithLogin(parameters: parameters))
            .catch({ [unowned self] error in
                if let networkError = error as? NetworkError {
                    // Invalid request token: The request token is either expired or invalid.
                    if networkError.statusCode == 33 {
                        return self.network.request(target: API.createRequestToken)
                    }
                }
                return Observable.error(error)
            })
    }
    
    func save(entity: T) -> Observable<Void> {
        return Observable.empty()
    }

}

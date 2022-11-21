//
//  CredentialRemoteDataSource.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 29/08/2022.
//

import Foundation
import RxSwift

final class CredentialRemoteDataSource: DataSource {
    typealias T = CredentialObject
    var network: Networking {
        guard let network = ServiceFacade.getService(Networking.self) else {
            preconditionFailure("Networking service not registered!")
        }
        return network
    }
    var preferences: PreferencesStorable {
        guard let preferences = ServiceFacade.getService(PreferencesStorable.self) else {
            preconditionFailure("User Preferences Storage service not registered!")
        }
        return preferences
    }
    
    func get(id: String?, parameters: [String: Any]) -> Observable<T?> {
        var parameters = parameters
        let storedToken = preferences.requestTokenId
        if let token = storedToken {
            parameters["request_token"] = token
        }

        return network.request(target: API.createSessionWithLogin(parameters: parameters))
            .debug("CredentialRemoteDataSource get \(id ?? "") with parameter: \(parameters)")
            .catch({ [weak self] error in
                if let self = self, let networkError = error as? NetworkError {
                    // status code == 33: Invalid request token: The request token is either expired or invalid.
                    // status code == 5: Invalid parameters: Your request parameters are incorrect.
                    if [33, 5].contains(networkError.statusCode) {
                        print("CredentialRemoteDataSource get \(id ?? "") with parameter: \(parameters) catch error: netowrk error with status 33")
                        return self.network.request(target: API.createRequestToken)
                    }
                }
                return Observable.error(error)
            })
            .do { [weak self] credentail in
                guard let self = self else {
                    return
                }
                self.preferences.requestTokenId = credentail?.requestToken
            }
    }
    
    func save(entity: T) -> Observable<Void> {
        return Observable.empty()
    }
}

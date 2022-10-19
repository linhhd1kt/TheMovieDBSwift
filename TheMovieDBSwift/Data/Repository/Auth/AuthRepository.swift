//
//  AuthRepository.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 11/10/2022.
//

import Action
import RxSwift

class AuthRepository: AuthRepositoryType {
    
    let login: Action<CredentialRequest, CredentialResponse>
    
    init(network: Networking = Network()) {        
        login = Action { input in
            network.request(target: input.toTarget())
                .catch({ error in
                    if let networkError = error as? NetworkError {
                        // status code == 33: Invalid request token: The request token is either expired or invalid.
                        // status code == 5: Invalid parameters: Your request parameters are incorrect.
                        if [33, 5].contains(networkError.statusCode) {
                            return network.request(target: API.createRequestToken)
                        }
                    }
                    return Observable.error(error)
                })
        }
    }
}

//
//  AuthRepository.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 11/10/2022.
//

import Action
import RxSwift

class AuthRepository: AuthRepositoryType {
//    lazy var network: Networking {
//        guard let network = ServiceFacade.getService(Networking.self) else {
//            preconditionFailure("Networking service not registered!")
//        }
//        return network
//    }
//
    let login: Action<CredentialRequest, CredentialResponse>

    init(network: Networking = Network()) {
        login = Action(workFactory: { input in
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
            
        })
//        login = Action { input in network.request(target: input.toTarget()) }
    }

}

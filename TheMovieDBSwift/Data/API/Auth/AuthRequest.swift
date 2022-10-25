//
//  AuthRequest.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 11/10/2022.
//

import Moya

struct CredentialRequest {
    let username: String
    let password: String
    let requestToken: String
}

extension CredentialRequest: ApiRequestable {
    func toTarget() -> TargetType {
        return API.createSessionWithLogin(parameters: ["username": username,
                                                       "password": password,
                                                       "request_token": requestToken])
    }
}

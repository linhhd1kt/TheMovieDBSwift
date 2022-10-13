//
//  AuthTranslator.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 11/10/2022.
//

import Foundation

protocol AuthTranslatorType {
    func toRequest(username: String, password: String, requestToken: String) -> CredentialRequest
    func toModel(reponse: CredentialResponse) -> CredentialModel
}

struct AuthTranslator: AuthTranslatorType {
    func toRequest(username: String, password: String, requestToken: String) -> CredentialRequest {
        return CredentialRequest(username: username, password: password, requestToken: requestToken)
    }
    func toModel(reponse: CredentialResponse) -> CredentialModel {
        return CredentialModel(success: reponse.success,
                               expiresAt: reponse.expiresAt,
                               requestToken: reponse.requestToken)
    }
}

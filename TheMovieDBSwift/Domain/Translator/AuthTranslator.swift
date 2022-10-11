//
//  AuthTranslator.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 11/10/2022.
//

import Foundation

protocol AuthTranslatorType {
    func toRequest(username: String, password: String) -> CredentialRequest
    func toModel(reponse: CredentialResponse) -> CredentialModel
}

struct AuthTranslator: AuthTranslatorType {
    func toRequest(username: String, password: String) -> CredentialRequest {
        return CredentialRequest(username: username, password: password)
    }
    func toModel(reponse: CredentialResponse) -> CredentialModel {
        return CredentialModel(success: reponse.success,
                               expiresAt: reponse.expiresAt,
                               requestToken: reponse.requestToken)
    }
}

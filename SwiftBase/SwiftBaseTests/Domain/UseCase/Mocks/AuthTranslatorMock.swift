//
//  AuthTranslatorMock.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Domain
import Data

class AuthTranslatorMock: AuthTranslatorType {
  func toRequest(username: String, password: String) -> CredentialRequest {
    return CredentialRequest(username: "dummy-username",
                             password: "dummy-password",
                             requestToken: "dummy-token")
  }
  func toModel(response: CredentialResponse) -> Credential {
    return Credential(success: true, expiresAt: nil, requestToken: nil)
  }
}

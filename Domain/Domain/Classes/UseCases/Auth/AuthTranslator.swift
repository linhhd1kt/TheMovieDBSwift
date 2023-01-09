//
//  AuthTranslator.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Data

public struct AuthTranslator: AuthTranslatorType {
  public func toRequest(username: String,
                        password: String) -> CredentialRequest {
    return CredentialRequest(username: username,
                             password: password,
                             requestToken: "")
  }

  public func toModel(response: CredentialResponse) -> Credential {
    return Credential(success: response.success,
                      expiresAt: response.expiresAt,
                      requestToken: response.requestToken)
  }
  
  public init() {    
  }
}

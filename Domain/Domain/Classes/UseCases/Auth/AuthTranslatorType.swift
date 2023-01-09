//
//  AuthTranslatorType.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Data

public protocol AuthTranslatorType {
  func toRequest(username: String, password: String) -> CredentialRequest
  func toModel(response: CredentialResponse) -> Credential
}

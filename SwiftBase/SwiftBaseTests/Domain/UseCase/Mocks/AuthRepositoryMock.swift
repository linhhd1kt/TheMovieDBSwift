//
//  AuthRepositoryMock.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Action
import Domain
import Data
import Services

enum AuthRepositoryResponseError: Error {
  case logicError
}

class AuthRepositoryErorrResponseMock: AuthRepositoryType {
  let login = Action<CredentialRequest, CredentialResponse> { _ in
    .error(ActionError.underlyingError(AuthRepositoryResponseError.logicError))
  }
}

class AuthRepositorySuccessResponseMock: AuthRepositoryType {
  let login = Action<CredentialRequest, CredentialResponse> { _ in
    .just(CredentialResponse(success: true, expiresAt: nil, requestToken: nil))
  }
}

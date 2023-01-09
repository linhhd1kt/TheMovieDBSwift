//
//  AuthUseCaseMock.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Action
import Domain
import RxSwift
import Extension

// MARK: - SuccessAuthUseCaseMock

public class SuccessAuthUseCaseMock {
  let loginAction = Action<(username: String, password: String), Credential> { _ in
      .just(Credential(success: true, expiresAt: nil, requestToken: nil))
  }
}

extension SuccessAuthUseCaseMock: AuthUseCaseType {
  public var input: AuthUseCaseInputType { return self }
  public var output: AuthUseCaseOutputType { return self }
}

extension SuccessAuthUseCaseMock: AuthUseCaseInputType {
  public var login: AnyObserver<(username: String, password: String)> {
    return loginAction.inputs
  }
}

extension SuccessAuthUseCaseMock: AuthUseCaseOutputType {
  public var loginResult: ActionResult<Credential> {
    return loginAction.toResult()
  }
}

// MARK: - ErrorAuthUseCaseMock

enum AuthUseCaseError: Error {
  case loginError
}

public class ErrorAuthUseCaseMock {
  let loginAction = Action<(username: String, password: String), Credential> { _ in
    .error(AuthUseCaseError.loginError)
  }
}

extension ErrorAuthUseCaseMock: AuthUseCaseType {
  public var input: AuthUseCaseInputType { return self }
  public var output: AuthUseCaseOutputType { return self }
}

extension ErrorAuthUseCaseMock: AuthUseCaseInputType {
  public var login: AnyObserver<(username: String, password: String)> {
    return loginAction.inputs
  }
}

extension ErrorAuthUseCaseMock: AuthUseCaseOutputType {
  public var loginResult: ActionResult<Credential> {
    return loginAction.toResult()
  }
}

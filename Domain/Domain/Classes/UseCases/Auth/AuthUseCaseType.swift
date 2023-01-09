//
//  AuthUseCaseType.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import RxSwift
import Data
import Extension

extension Credential: Equatable {
  public static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.success == rhs.success
    && lhs.expiresAt == rhs.expiresAt
    && lhs.requestToken == rhs.requestToken
  }
}

public protocol AuthUseCaseType {
  var input: AuthUseCaseInputType { get }
  var output: AuthUseCaseOutputType { get }
}

public protocol AuthUseCaseInputType {
  var login: AnyObserver<(username: String, password: String)> { get }
}

public protocol AuthUseCaseOutputType {
  var loginResult: ActionResult<Credential> { get }
}

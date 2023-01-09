//
//  LoginViewModelType.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import RxSwift
import Domain
import Extension
import Data

public protocol LoginViewModelType {
  var input: LoginViewModelInputType { get }
  var output: LoginViewModelOutputType { get }
}

public protocol LoginViewModelInputType {
  var username: AnyObserver<String> { get }
  var password: AnyObserver<String> { get }
  var loginAction: AnyObserver<Void> { get }
  var forgotPasswordAction: AnyObserver<Void> { get }
  var registerAction: AnyObserver<Void> { get }
}

public protocol LoginViewModelOutputType {
  var loginResult: ActionResult<Credential> { get }
  var loginButtonEnabled: Observable<Bool> { get }
}

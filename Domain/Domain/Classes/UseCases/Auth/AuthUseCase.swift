//
//  AuthUseCase.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import RxSwift
import RxCocoa
import Data
import Extension

public class AuthUseCase {
  // MARK: - Dependency
  private let repository: AuthRepositoryType
  private let translator: AuthTranslatorType

  // MARK: - Input
  
  private let loginObserver = PublishSubject<(username: String, password: String)>()

  // MARK: - Other

  public init(repository: AuthRepositoryType, translator: AuthTranslatorType) {
    self.repository = repository
    self.translator = translator
    bindInput()
  }

  private func bindInput() {
    loginObserver
      .withUnretained(self)
      .map { this, info in
        this.translator.toRequest(username: info.username, password: info.password)
      }
      .bind(to: repository.login.inputs)
      .disposed(by: disposeBag)
  }
}

// MARK: - AuthUseCaseType

extension AuthUseCase: AuthUseCaseType {
  public var input: AuthUseCaseInputType { return self }
  public var output: AuthUseCaseOutputType { return self }
}

// MARK: - AuthUseCaseInputType

extension AuthUseCase: AuthUseCaseInputType {
  public var login: AnyObserver<(username: String, password: String)> {
    return loginObserver.asObserver()
  }
}

// MARK: - AuthUseCaseOutputType

extension AuthUseCase: AuthUseCaseOutputType {
  public var loginResult: ActionResult<Credential> {
    return repository.login.toResult().map { self.translator.toModel(response: $0) }
  }
}

extension AuthUseCase: HasDisposeBag {}

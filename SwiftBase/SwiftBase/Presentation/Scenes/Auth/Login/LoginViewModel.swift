//
//  LoginViewModel.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Design
import RxCocoa
import RxSwift
import Services
import Data
import Domain
import Extension
import Darwin

public final class LoginViewModel: BaseViewModel {
  // MARK: - Dependency

  private let usecase: AuthUseCaseType

  // MARK: - Input

  private let usernameTextObserver = BehaviorSubject<String>(value: "")
  private let passwordTextObserver = BehaviorSubject<String>(value: "")
  private let loginActionObserver = PublishSubject<Void>()
  private let registerActionObserver = PublishSubject<Void>()
  private let forgotPasswordActionObserver = PublishSubject<Void>()
  private let confirmOkObserver = PublishSubject<Void>()
  private let confirmCancelObserver = PublishSubject<Void>()

  // MARK: - Output

  private let errorObserver = BehaviorSubject<String>(value: "")
  private let loginButtonEnabledObserver = BehaviorSubject<Bool>(value: false)
  private let confirmOkResultObserver = PublishSubject<String>()
  private let confirmCancelResultObserver = PublishSubject<String>()

  public init(usecase: AuthUseCaseType) {
    self.usecase = usecase
    super.init()
    binding()
    
    #if DEVELOPMENT
    usernameTextObserver.onNext("linhhd.kt")
    passwordTextObserver.onNext("Veronica@060983")
    loginButtonEnabledObserver.onNext(true)
    #endif
    
  }

  private func binding() {
    // login button enabled when username and password is not empty
    let loginInfo = Observable.combineLatest(usernameTextObserver, passwordTextObserver)
    loginInfo
      .map { !$0.isEmpty && !$1.isEmpty }
      .distinctUntilChanged()
      .bind(to: loginButtonEnabledObserver)
      .disposed(by: disposeBag)
    loginActionObserver
      .withLatestFrom(loginInfo.map { ($0, $1) })
      .bind(to: usecase.input.login)
      .disposed(by: disposeBag)
    confirmOkObserver.map { _ in "Confirm OK Result" }
      .bind(to: confirmOkResultObserver)
      .disposed(by: disposeBag)
    confirmCancelObserver.map { _ in "Confirm Cancel Result" }
      .bind(to: confirmCancelResultObserver)
      .disposed(by: disposeBag)
  }
}

extension LoginViewModel: LoginViewModelType {
  public var input: LoginViewModelInputType {
    return self
  }

  public var output: LoginViewModelOutputType {
    return self
  }
}

extension LoginViewModel: LoginViewModelInputType {
  public var username: AnyObserver<String> {
    return usernameTextObserver.asObserver()
  }

  public var password: AnyObserver<String> {
    return passwordTextObserver.asObserver()
  }

  public var loginAction: AnyObserver<Void> {
    return loginActionObserver.asObserver()
  }

  public var registerAction: AnyObserver<Void> {
    return registerActionObserver.asObserver()
  }

  public var forgotPasswordAction: AnyObserver<Void> {
    return forgotPasswordActionObserver.asObserver()
  }

  public var confirmOk: AnyObserver<Void> {
    return confirmOkObserver.asObserver()
  }

  public var confirmCancel: AnyObserver<Void> {
    return confirmCancelObserver.asObserver()
  }
}

extension LoginViewModel: LoginViewModelOutputType {
  public var confirmOkResult: Observable<String> {
    return confirmOkResultObserver.asObservable()
  }

  public var confirmCancelResult: Observable<String> {
    return confirmCancelResultObserver.asObservable()
  }

  public var loginButtonEnabled: Observable<Bool> {
    return loginButtonEnabledObserver
  }

  public var loginResult: ActionResult<Credential> {
    let enabled = Observable.combineLatestAll(usecase.output.loginResult.enabled,
                                              loginButtonEnabledObserver)
    return usecase.output.loginResult.swapEnabled(enabled)
  }
}

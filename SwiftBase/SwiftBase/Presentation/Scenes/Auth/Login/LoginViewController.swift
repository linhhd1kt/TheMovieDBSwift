//
//  LoginViewController.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Design
import Domain
import RxCocoa
import RxSwift
import UIKit

final class LoginViewController: RickViewController {
  @IBOutlet private var usernameInput: Input!
  @IBOutlet private var passwordInput: Input!
  @IBOutlet private var loginButton: FilledButton!
  @IBOutlet private var forgotPasswordButton: FilledButton!
  @IBOutlet private var registerButton: FilledButton!

  private let viewModel: LoginViewModelType

  // MARK: - Initialization

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  init(viewModel: LoginViewModelType, navigationViewModel: NavigationViewModelType) {
    self.viewModel = viewModel
    super.init(navigationViewModel: navigationViewModel)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    bindInput(viewModel.input)
    bindOutput(viewModel.output)    
  }

  private func bindInput(_ input: LoginViewModelInputType) {
    usernameInput.rx.outputText
      .filterNil()
      .bind(to: input.username)
      .disposed(by: disposeBag)
    passwordInput.rx.outputText
      .filterNil()
      .bind(to: input.password)
      .disposed(by: disposeBag)
    loginButton.rx.tap
      .bind(to: input.loginAction)
      .disposed(by: disposeBag)
  }

  private func bindOutput(_ output: LoginViewModelOutputType) {
    output.loginResult.enabled
      .bind(to: loginButton.rx.enabled)
      .disposed(by: disposeBag)
    output.loginResult.errors
      .bind(to: rx.showError)
      .disposed(by: disposeBag)
    output.loginResult.executing
      .bind(to: rx.loading)
      .disposed(by: disposeBag)
  }
}

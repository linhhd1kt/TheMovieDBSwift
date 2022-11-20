//
//  LoginViewController.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 14/10/2022.
//

import RxSwift
import UIKit
import RxCocoa
import ProgressHUD

final class LoginViewController: RickViewController {
    @IBOutlet private weak var usernameInput: Input!
    @IBOutlet private weak var passwordInput: Input!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var forgotPasswordButton: UIButton!
    @IBOutlet private weak var registerButton: UIButton!
    
    private let viewModel: LoginViewModelType
        
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: LoginViewModelType = LoginViewModel(),
         navigationViewModel: NavigationViewModelType) {
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
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        output.loginResult.errors
            .bind(to: rx.showError)
            .disposed(by: disposeBag)
        output.loginResult.executing
            .bind(to: rx.loading)
            .disposed(by: disposeBag)
    }
}

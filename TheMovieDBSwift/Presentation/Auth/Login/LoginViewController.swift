//
//  LoginViewController.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 14/10/2022.
//

import RxSwift
import UIKit
import RxCocoa
import NSObject_Rx
import ProgressHUD

final class LoginViewController: BaseViewController {
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var forgotPasswordButton: UIButton!
    @IBOutlet private weak var registerButton: UIButton!
    
    private let viewModel: LoginViewModelType
        
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: LoginViewModelType = LoginViewModel()) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindInput(viewModel.input)
        bindOutput(viewModel.output)
    }
    
    private func bindInput(_ input: LoginViewModelInputType) {
        usernameTextField.rx.text
            .filterNil()
            .bind(to: input.username)
            .disposed(by: disposeBag)
        passwordTextField.rx.text
            .filterNil()
            .bind(to: input.password)
            .disposed(by: disposeBag)
        loginButton.rx.tap
            .bind(to: input.loginAction)
            .disposed(by: disposeBag)
    }

    private func bindOutput(_ output: LoginViewModelOutputType) {
        output.loginResult.enabled
            .debug("Login Action Enabled")
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        output.loginResult.errors
            .debug("Error")
            .bind(to: rx.showError)
            .disposed(by: disposeBag)
        output.loginResult.executing
            .debug("Executing")
            .bind(to: rx.loading)
            .disposed(by: disposeBag)
    }
}

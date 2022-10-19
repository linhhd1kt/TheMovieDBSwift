//
//  DashboardViewController.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 19/10/2022.
//

import UIKit

class DashboardViewController: ViewControllerWithSideMenu {

    private let viewModel: DashboardViewModelType
        
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: DashboardViewModelType = DashboardViewModel()) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindInput(viewModel.input)
        bindOutput(viewModel.output)
    }
    
    private func bindInput(_ input: DashboardViewModelInputType) {
//        usernameTextField.rx.text
//            .filterNil()
//            .bind(to: input.username)
//            .disposed(by: disposeBag)
//        passwordTextField.rx.text
//            .filterNil()
//            .bind(to: input.password)
//            .disposed(by: disposeBag)
//        loginButton.rx.tap
//            .bind(to: input.loginAction)
//            .disposed(by: disposeBag)
    }

    private func bindOutput(_ output: DashboardViewModelOutputType) {
//        output.loginResult.enabled
//            .debug("Login Action Enabled")
//            .bind(to: loginButton.rx.isEnabled)
//            .disposed(by: disposeBag)
//        output.loginResult.errors
//            .debug("Error")
//            .bind(to: rx.showError)
//            .disposed(by: disposeBag)
//        output.loginResult.executing
//            .debug("Executing")
//            .bind(to: rx.loading)
//            .disposed(by: disposeBag)
    }

}

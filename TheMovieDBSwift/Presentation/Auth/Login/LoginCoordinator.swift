//
//  LoginCoordinator.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 14/10/2022.
//

import RxSwift
import UIKit

class LoginCoordinator: BaseCoordinator {
    
    let viewModel: LoginViewModelType
    
    init(navigationController: UINavigationController,
         viewModel: LoginViewModelType) {
        self.viewModel = viewModel
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        let loginViewController = LoginViewController(viewModel: viewModel)
        viewModel.output
            .loginResult
            .elements
            .filter { $0.success == true }
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.navigationController.viewControllers = []
                self.parentCoordinator?.didFinish(coordinator: self)
                (self.parentCoordinator as? LoginListener)?.didLogedIn()
            })
            .disposed(by: disposeBag)
            self.navigationController.viewControllers = [loginViewController]
        
    }
}

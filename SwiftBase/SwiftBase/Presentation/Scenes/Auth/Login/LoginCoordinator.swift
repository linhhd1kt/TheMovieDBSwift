//
//  LoginCoordinator.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Domain
import RxSwift
import UIKit

class LoginCoordinator: BaseCoordinator {
  let viewModel: LoginViewModelType
  let navigationViewModel: NavigationViewModelType

  init(navigationController: UINavigationController,
       viewModel: LoginViewModelType,
       navigationViewModel: NavigationViewModelType)
  {
    self.viewModel = viewModel
    self.navigationViewModel = navigationViewModel
    super.init(navigationController: navigationController)
  }

  override func start() {
    let loginViewController = LoginViewController(viewModel: viewModel,
                                                  navigationViewModel: navigationViewModel)
    viewModel.output
      .loginResult
      .elements
      .filter { $0.success == true }
      .subscribe(onNext: { [weak self] _ in
        guard let self = self else {
          return
        }
        self.navigationController.viewControllers = []
        self.parentCoordinator?.didFinish(coordinator: self)
        (self.parentCoordinator as? LoginListener)?.didLogedIn()
      })
      .disposed(by: disposeBag)
    navigationController.viewControllers = [loginViewController]
  }
}

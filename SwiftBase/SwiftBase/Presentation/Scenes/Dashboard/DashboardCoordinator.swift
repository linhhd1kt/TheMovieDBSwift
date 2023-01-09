//
//  LoginCoordinator.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Domain
import RxSwift
import UIKit

class DashboardCoordinator: BaseCoordinator {
  let viewModel: DashboardViewModelType
  let navigationViewModel: NavigationViewModelType

  init(navigationController: UINavigationController,
       viewModel: DashboardViewModelType,
       navigationViewModel: NavigationViewModelType)
  {
    self.viewModel = viewModel
    self.navigationViewModel = navigationViewModel
    super.init(navigationController: navigationController)
  }

  override func start() {
    let dashboardViewController = DashboardViewController(viewModel: viewModel,
                                                          navigationViewModel: navigationViewModel)
    navigationController.viewControllers = [dashboardViewController]
  }
}

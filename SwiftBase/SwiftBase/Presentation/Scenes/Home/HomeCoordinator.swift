//
//  HomeCoordinator.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Domain
import RxSwift
import Services
import UIKit

class HomeCoordinator: BaseCoordinator {
  let viewModel: HomeViewModelType
  let navigationViewModel: NavigationViewModelType

  init(navigationController: UINavigationController,
       viewModel: HomeViewModelType,
       navigationViewModel: NavigationViewModelType)
  {
    self.viewModel = viewModel
    self.navigationViewModel = navigationViewModel
    super.init(navigationController: navigationController)
  }

  override func start() {
    let homeViewController = HomeViewController(viewModel: viewModel,
                                                navigationViewModel: navigationViewModel)
//        viewModel.output
//            .HomeResult
//            .elements
//            .filter { $0.token != nil }
//            .subscribe(onNext: { [weak self] _ in
//                guard let self = self else {
//                    return
//                }
//                self.navigationController.viewControllers = []
//                self.parentCoordinator?.didFinish(coordinator: self)
//                (self.parentCoordinator as? HomeListener)?.didLogedIn()
//            })
//            .disposed(by: disposeBag)
    navigationController.setViewControllers([homeViewController], animated: true)
  }
}

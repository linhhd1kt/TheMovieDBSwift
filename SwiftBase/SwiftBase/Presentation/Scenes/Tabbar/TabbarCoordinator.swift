//
//  TabbarCoordinator.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Design
import Domain
import RxSwift
import Services
import UIKit

final class TabbarCoordinator: BaseCoordinator {
  let viewModel: TabbarViewModelType
  let navigationViewModel: NavigationViewModelType

  init(navigationController: UINavigationController,
       viewModel: TabbarViewModelType,
       navigationViewModel: NavigationViewModelType)
  {
    self.viewModel = viewModel
    self.navigationViewModel = navigationViewModel
    super.init(navigationController: navigationController)
  }

  override func start() {
    let tabbar = TabbarController(viewModel: viewModel, navigationViewModel: navigationViewModel)
    let homeViewModel = HomeViewModel()
    let homeViewController = HomeViewController(viewModel: homeViewModel,
                                                navigationViewModel: navigationViewModel)
    homeViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
    tabbar.viewControllers = [homeViewController, homeViewController]
    navigationController.setViewControllers([tabbar], animated: true)
  }
}

//
//  MovieListCoordinator.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Domain
import UIKit

class MovieListCoordinator: BaseCoordinator {
  let viewModel: MovieListViewModelType
  let navigationViewModel: NavigationViewModelType

  init(navigationController: UINavigationController,
       viewModel: MovieListViewModelType,
       navigationViewModel: NavigationViewModelType)
  {
    self.viewModel = viewModel
    self.navigationViewModel = navigationViewModel
    super.init(navigationController: navigationController)
  }

  override func start() {
    let viewController = MovieListViewController(viewModel: viewModel,
                                                 navigationViewModel: navigationViewModel)

    navigationController.viewControllers = [viewController]
  }
}

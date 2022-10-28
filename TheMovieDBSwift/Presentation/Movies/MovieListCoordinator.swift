//
//  MovieListCoordinator.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 20/10/2022.
//

import UIKit

class MovieListCoordinator: BaseCoordinator {
    let viewModel: MovieListViewModelType
    let navigationViewModel: NavigationViewModelType
    
    init(navigationController: UINavigationController,
         viewModel: MovieListViewModelType,
         navigationViewModel: NavigationViewModelType) {
        self.viewModel = viewModel
        self.navigationViewModel = navigationViewModel
        super.init(navigationController: navigationController)
    }

    override func start() {
        let viewController = MovieListViewController(viewModel: viewModel,
                                                     navigationViewModel: navigationViewModel)
        
        self.navigationController.viewControllers = [viewController]
    }
}

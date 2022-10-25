//
//  MovieListCoordinator.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 20/10/2022.
//

import UIKit

class MovieListCoordinator: BaseCoordinator {
    
    let viewModel: MovieListViewModelType
    
    init(navigationController: UINavigationController,
         viewModel: MovieListViewModelType) {
        self.viewModel = viewModel
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        let viewController = MovieListViewController(viewModel: viewModel)
        self.navigationController.viewControllers = [viewController]
    }
}


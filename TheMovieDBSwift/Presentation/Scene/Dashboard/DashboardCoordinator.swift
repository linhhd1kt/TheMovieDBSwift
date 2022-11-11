//
//  LoginCoordinator.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 14/10/2022.
//

import RxSwift
import UIKit

class DashboardCoordinator: BaseCoordinator {
    
    let viewModel: DashboardViewModelType
    let navigationViewModel: NavigationViewModelType
    
    init(navigationController: UINavigationController,
         viewModel: DashboardViewModelType,
         navigationViewModel: NavigationViewModelType) {
        self.viewModel = viewModel
        self.navigationViewModel = navigationViewModel
        super.init(navigationController: navigationController)
    }

    override func start() {
        let dashboardViewController = DashboardViewController(viewModel: viewModel,
                                                              navigationViewModel: self.navigationViewModel)
        self.navigationController.viewControllers = [dashboardViewController]
    }
}

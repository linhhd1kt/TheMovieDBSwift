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
    
    init(navigationController: UINavigationController, viewModel: DashboardViewModelType) {
        self.viewModel = viewModel
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        let dashboardViewController = DashboardViewController(viewModel: viewModel)
        self.navigationController.viewControllers = [dashboardViewController]
        
    }
}

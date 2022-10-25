//
//  AppCoordinator.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 14/10/2022.
//

import Foundation
import UIKit
import SideMenu

class AppCoordinator: BaseCoordinator {
    
    private var userPreference: UserPreferencesStorable {
        guard let preference = ServiceFacade.getService(UserPreferencesStorable.self) else {
            fatalError("User preferences should be initilized!")
        }
        return preference
    }
    
    init() {
        super.init(navigationController: UINavigationController())
    }
        
    override func start() {
        navigationController.navigationBar.isHidden = true
//        setUpSideMenu()
        if let _: String = userPreference.value(for: UserPreferencesKey.requestTokenId.rawValue) {
            showDashboard()
        } else {
            showSignIn()
        }
    }
    
    private func showSignIn() {
        removeChildCoordinators()
        let viewModel = LoginViewModel()
        let coordinator = LoginCoordinator(navigationController: self.navigationController,
                                                viewModel: viewModel)
        start(coordinator: coordinator)
    }
    
    private func showDashboard() {
        removeChildCoordinators()
        let viewModel = DrawerMenuViewModel()
        let coordinator = DrawerMenuCoordinator(navigationController: self.navigationController,
                                                viewModel: viewModel)
        start(coordinator: coordinator)
    }
}

protocol LoginListener {
    func didLogedIn()
    func didLogOut()
}

extension AppCoordinator: LoginListener {
    func didLogedIn() {
        print("XXX Login In")
        // TODO: Navigate to Dashboard
    }
    func didLogOut() {
        print("XXX Log Out")
        // TODO: Navigate to Login
    }
}


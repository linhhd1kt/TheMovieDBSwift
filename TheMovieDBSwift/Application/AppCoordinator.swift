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
        setUpSideMenu()
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
                                                drawerMenuViewModel: viewModel)
        start(coordinator: coordinator)
    }
    
    private func setUpSideMenu() {
        // Define the menus
        let leftMenuNavigationController = SideMenuNavigationController(rootViewController: DrawerMenuViewController())
        SideMenuManager.default.leftMenuNavigationController = leftMenuNavigationController
        leftMenuNavigationController.navigationBar.isHidden = true

        let style = SideMenuPresentationStyle.menuSlideIn
        style.backgroundColor = .black
        style.presentingEndAlpha = 0.32
        style.onTopShadowColor = .black
        style.onTopShadowRadius = 4.0
        style.onTopShadowOpacity = 0.2
        style.onTopShadowOffset = CGSize(width: 2.0, height: 0.0)

        var settings = SideMenuSettings()
        settings.presentationStyle = style
        settings.menuWidth = max(round(min((UIScreen.main.bounds.width), (UIScreen.main.bounds.height)) * 0.75), 240)
        settings.statusBarEndAlpha = 0.0

        leftMenuNavigationController.settings = settings
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


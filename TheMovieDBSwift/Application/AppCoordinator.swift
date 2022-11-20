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
    private let navigationItemFactory: NavigationItemCreatable
    private let navigationViewModel: NavigationViewModelType
    
    init(navigationItemFactory: NavigationItemCreatable = NavigationItemFactory(),
         navigationViewModel: NavigationViewModelType = NavigationViewModel()) {
        self.navigationItemFactory = navigationItemFactory
        self.navigationViewModel = navigationViewModel
        super.init(navigationController: UINavigationController())
        setupAppearance()
    }
    
    override func start() {
        showDashboard()
    }
    
    func setupAppearance() {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor: design.style.colors.background]
            appearance.backgroundColor = design.style.colors.primary
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().barTintColor = design.style.colors.surfaceTint
            UINavigationBar.appearance().tintColor = design.style.colors.background
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: design.style.colors.onBackground]
        }
    }
    
    private func showLogin() {
        removeChildCoordinators()
        let viewModel = LoginViewModel()
        let coordinator = LoginCoordinator(navigationController: self.navigationController,
                                           viewModel: viewModel,
                                           navigationViewModel: navigationViewModel)
        start(coordinator: coordinator)
    }
    
    private func showDashboard() {
        removeChildCoordinators()
        let coordinator = DrawerMenuCoordinator(navigationController: self.navigationController,
                                                navigationViewModel: navigationViewModel)
        start(coordinator: coordinator)
    }
}

protocol LoginListener {
    func didLogedIn()
    func didLogOut()
}

extension AppCoordinator: LoginListener {
    func didLogedIn() {
        showDashboard()
    }
    func didLogOut() {
        showLogin()
    }
}

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
    
    init(navigationItemFactory: NavigationItemCreatable = NavigationItemFactory()) {
        self.navigationItemFactory = navigationItemFactory
        super.init(navigationController: UINavigationController())
        setupAppearance()
    }
    
    override func start() {
        if let _: String = userPreference.value(for: UserPreferencesKey.requestTokenId.rawValue) {
            showDashboard()
        } else {
            showSignIn()
        }
    }
    
    func setupAppearance() {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor: R.color.onBackground]
            appearance.backgroundColor = R.color.primary()
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().barTintColor = R.color.primary()
            UINavigationBar.appearance().tintColor = R.color.background()
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: R.color.onPrimary]
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
        let viewModel = NavigationViewModel()
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
    }
    func didLogOut() {
    }
}

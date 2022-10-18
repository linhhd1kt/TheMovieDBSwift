//
//  AppCoordinator.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 14/10/2022.
//

import Foundation
import UIKit

class AppCoordinator: BaseCoordinator {

    private var window = UIWindow(frame: UIScreen.main.bounds)
    
    override func start() {
        navigationController.navigationBar.isHidden = true
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        // TODO: here you could check if user is signed in and show appropriate screen
        let coordinator = LoginCoordinator(viewModel: LoginViewModel())
        coordinator.navigationController = navigationController
        start(coordinator: coordinator)
    }
}

protocol LoginListener {
    func didLogedIn()
}

extension AppCoordinator: LoginListener {
    func didLogedIn() {
        print("Login In")
        // TODO: Navigate to Dashboard
    }
}


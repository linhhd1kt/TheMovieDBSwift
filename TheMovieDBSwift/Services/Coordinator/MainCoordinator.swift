//
//  MainCoordinator.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 26/08/2022.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        gotoLogin()
    }
    
    func gotoLogin() {
        let respository = CredentialRepository(localDataSource: CredentialLocalDataSource(),
                                                   remoteDataSource: CredentialRemoteDataSource())
        let useCase = DefaultAuthUseCase(respository: respository)
        let viewModel = LoginViewModel(authUseCase: useCase)
        let vc = LoginViewController(viewModel: viewModel)
        self.navigationController = UINavigationController(rootViewController: vc)
    }
}

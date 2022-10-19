//
//  BaseCoordinator.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 14/10/2022.
//

import UIKit
import RxSwift
import NSObject_Rx

class BaseCoordinator: CoordinatorType {    
    var childCoordinators: [CoordinatorType] = []
    var parentCoordinator: CoordinatorType?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        fatalError("Start method must be implemented")
    }
    
    func start(coordinator: CoordinatorType) {
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    func didFinish(coordinator: CoordinatorType) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
    
    func removeChildCoordinators() {
        childCoordinators.forEach { $0.removeChildCoordinators() }
        childCoordinators.removeAll()
    }
}

extension BaseCoordinator: HasDisposeBag {}

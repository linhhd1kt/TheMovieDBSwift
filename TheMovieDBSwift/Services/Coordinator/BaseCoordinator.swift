//
//  BaseCoordinator.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 14/10/2022.
//

import UIKit
import RxSwift

class BaseCoordinator: NSObject, CoordinatorType {
    var childCoordinators: [CoordinatorType] = []
    var parentCoordinator: CoordinatorType?
    var navigationController: UINavigationController
    
    var logger: Logger {
        guard let logger = ServiceFacade.getService(Logable.self) as? Logger else {
            fatalError("Logger should be implemented!")
        }
        return logger
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        logger.debug("\(className) is initialized.")
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
    
    deinit {
        logger.debug("\(className) is release.")
    }
}

extension BaseCoordinator: HasDisposeBag { }
extension BaseCoordinator: HasDeSign { }

//
//  BaseCoordinator.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import RxSwift
import Domain
import Extension

open class BaseCoordinator: NSObject, CoordinatorType {
  var childCoordinators: [CoordinatorType] = []
  public weak var parentCoordinator: CoordinatorType?
  public var navigationController: UINavigationController

  public init(navigationController: UINavigationController) {
    self.navigationController = navigationController
    self.navigationController.isToolbarHidden = true
    super.init()
  }

  open func start() {
    fatalError("Start method must be implemented")
  }

  open func start(coordinator: CoordinatorType) {
    childCoordinators.append(coordinator)
    coordinator.parentCoordinator = self
    coordinator.start()
  }

  open func didFinish(coordinator: CoordinatorType) {
    if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
      childCoordinators.remove(at: index)
    }
  }

  open func removeChildCoordinators() {
    childCoordinators.forEach { $0.removeChildCoordinators() }
    childCoordinators.removeAll()
  }

  deinit {}
}

extension BaseCoordinator: HasDisposeBag {}

//
//  CoordinatorType.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import UIKit

public protocol CoordinatorType: AnyObject {
  var navigationController: UINavigationController { get set }
  var parentCoordinator: CoordinatorType? { get set }

  func start()
  func start(coordinator: CoordinatorType)
  func didFinish(coordinator: CoordinatorType)
  func removeChildCoordinators()
}

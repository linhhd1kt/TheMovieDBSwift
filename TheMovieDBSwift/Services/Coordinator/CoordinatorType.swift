//
//  Coordinator.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 18/10/2022.
//

import Foundation
import UIKit

protocol CoordinatorType: AnyObject {
    var navigationController: UINavigationController { get set }
    var parentCoordinator: CoordinatorType? { get set }
    
    func start()
    func start(coordinator: CoordinatorType)
    func didFinish(coordinator: CoordinatorType)
    func removeChildCoordinators()
}

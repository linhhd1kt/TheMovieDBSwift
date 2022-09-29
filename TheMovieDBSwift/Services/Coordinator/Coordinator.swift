//
//  Coordinator.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 26/08/2022.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

//
//  AppCoordinator.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Design
import Domain
import Foundation
import Services
import SideMenu

class AppCoordinator: BaseCoordinator {
  private var design: Designable {
    guard let design = ServiceFacade.getService(Designable.self) else {
      fatalError("Design should be initilized!")
    }
    return design
  }

  private var network: Networking {
    guard let network = ServiceFacade.getService(Networking.self) else {
      fatalError("Network service should be initilized!")
    }
    return network
  }

  private let navigationViewModel: NavigationViewModelType

  init(navigationViewModel: NavigationViewModelType = NavigationViewModel()) {
    self.navigationViewModel = navigationViewModel
    let navigationController = UINavigationController()
    super.init(navigationController: navigationController)
    setupAppearance()
  }

  override func start() {
    setUpSideMenu()
    showMenu()
  }

  func setupAppearance() {
    design.initialized()
  }

  private func showMenu() {
    removeChildCoordinators()
    let coordinator = MenuCoordinator(navigationController: navigationController,
                                      navigationViewModel: navigationViewModel)
    start(coordinator: coordinator)
  }

  private func setUpSideMenu() {
    // Define the menus
    let drawer = MenuViewController(viewModel: navigationViewModel)
    let leftMenuNavigationController = SideMenuNavigationController(rootViewController: drawer)
    SideMenuManager.default.leftMenuNavigationController = leftMenuNavigationController
    leftMenuNavigationController.navigationBar.isHidden = true
    leftMenuNavigationController.blurEffectStyle = .prominent

    let style = SideMenuPresentationStyle.menuSlideIn
    style.backgroundColor = design.style.colors.background
    style.presentingEndAlpha = 0.32
    style.onTopShadowColor = design.style.colors.primary
    style.onTopShadowRadius = 4.0
    style.onTopShadowOpacity = 0.2
    style.onTopShadowOffset = CGSize(width: 2.0, height: 0.0)

    var settings = SideMenuSettings()
    settings.presentationStyle = style
    settings.menuWidth = max(round(min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * 0.75), 240)
    settings.statusBarEndAlpha = 0.0
    leftMenuNavigationController.settings = settings
  }
}

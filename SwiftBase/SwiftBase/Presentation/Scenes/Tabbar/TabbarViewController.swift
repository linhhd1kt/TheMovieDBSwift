//
//  TabbarViewController.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Domain
import SideMenu
import UIKit

final class TabbarController: UITabBarController {
  // MARK: - Gesture

  private var panGesture = UIPanGestureRecognizer()
  private var edgeGesture = UIScreenEdgePanGestureRecognizer()

  private let viewModel: TabbarViewModelType
  private let navigationViewModel: NavigationViewModelType

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  init(viewModel: TabbarViewModelType, navigationViewModel: NavigationViewModelType) {
    self.viewModel = viewModel
    self.navigationViewModel = navigationViewModel
    super.init(nibName: nil, bundle: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupGesture()
  }

  override public func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    enableSideMenu()
  }

  override public func viewWillDisappear(_: Bool) {
    super.viewWillDisappear(true)
    disableSideMenu()
  }

  private func setupGesture() {
    panGesture = SideMenuManager.default.addPanGestureToPresent(toView: tabBar)
    if let view = view {
      edgeGesture = SideMenuManager.default
        .addScreenEdgePanGesturesToPresent(toView: view, forMenu: .left)
    }
  }

  private func disableSideMenu() {
    panGesture.isEnabled = false
    edgeGesture.isEnabled = false
  }

  private func enableSideMenu() {
    panGesture.isEnabled = true
    edgeGesture.isEnabled = true
  }

  func showSideMenu() {
    guard let leftMenu = SideMenuManager.default.leftMenuNavigationController else {
      return
    }
    present(leftMenu, animated: true, completion: nil)
  }
}

extension TabbarController: UITabBarControllerDelegate {
  func tabBarController(_: UITabBarController, shouldSelect _: UIViewController) -> Bool {
    return true
  }

  func tabBarController(_: UITabBarController, didSelect viewController: UIViewController) {
    print("TabbarController didSelect viewController: \(viewController.className)")
  }

  func tabBarController(_: UITabBarController, willBeginCustomizing _: [UIViewController]) {}

  func tabBarController(_: UITabBarController, willEndCustomizing _: [UIViewController], changed _: Bool) {}

  func tabBarController(_: UITabBarController, didEndCustomizing _: [UIViewController], changed _: Bool) {}

  func tabBarControllerSupportedInterfaceOrientations(_: UITabBarController) -> UIInterfaceOrientationMask {
    return .all
  }

  func tabBarControllerPreferredInterfaceOrientationForPresentation(_: UITabBarController) -> UIInterfaceOrientation {
    return .portraitUpsideDown
  }

  func tabBarController(_: UITabBarController, interactionControllerFor _: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    return nil
  }

  func tabBarController(_: UITabBarController, animationControllerForTransitionFrom _: UIViewController, to _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return nil
  }
}

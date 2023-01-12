//
//  SceneDelegate.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Domain
import Services
import SideMenu
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//  var window: UIWindow?
  private var appCoordinator: CoordinatorType?

  func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else {
      return
    }
    let window = UIWindow(windowScene: windowScene)
    appCoordinator = AppCoordinator(window: window)
    appCoordinator?.start()
  }

  func sceneDidDisconnect(_: UIScene) {}

  func sceneDidBecomeActive(_: UIScene) {}

  func sceneWillResignActive(_: UIScene) {}

  func sceneWillEnterForeground(_: UIScene) {}

  func sceneDidEnterBackground(_: UIScene) {}
}

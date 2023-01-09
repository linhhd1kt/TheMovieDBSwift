//
//  AppDelegate.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Domain
import FontBlaster
import Foundation
import RxCocoa
import RxSwift
import Services
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    ServiceFacade.registerDefaultService()
//        #if DEBUG
//        _ = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
//            .subscribe(onNext: { _ in
//                print("Rx Resource Count: \(Resources.total)")
//            })
//        #endif
    FontBlaster.blast()
    return true
  }

  func application(_: UIApplication, configurationForConnecting _: UISceneSession, options _: UIScene.ConnectionOptions) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: .windowApplication)
  }
}

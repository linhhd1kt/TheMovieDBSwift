//
//  AppDelegate.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 25/08/2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appCoordinator: Coordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ServiceFacade.registerDefaultService(from: window)
        self.appCoordinator = ServiceFacade.getService(Coordinator.self)
        AppAppearance.setupAppearance()
        appCoordinator?.start()
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }
}

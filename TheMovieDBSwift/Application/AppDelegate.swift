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
    var coordiate: Coordinator? {
        return ServiceFacade.getService(Coordinator.self)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppAppearance.setupAppearance()
        window = UIWindow(frame: UIScreen.main.bounds)
        ServiceFacade.registerDefaultService(from: window)
        coordiate?.start()
        window?.rootViewController = coordiate?.navigationController        
        window?.makeKeyAndVisible()    
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }
}

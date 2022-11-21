//
//  AppDelegate.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 25/08/2022.
//

import UIKit
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ServiceFacade.registerDefaultService()
        #if DEBUG
        _ = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { _ in
                print("Rx Resource Count: \(Resources.total)")
            })
        #endif
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "default", sessionRole: .windowApplication)
    }
}

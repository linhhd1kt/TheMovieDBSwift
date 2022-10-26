//
//  AppAppearance.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 26/08/2022.
//

import Foundation
import UIKit

final class AppAppearance {
    
    static func setupAppearance() {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.backgroundColor = .blue
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().barTintColor = .blue
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        
        let buttonContainer = UIView(frame: CGRect(x: 0, y: 0, width: 62, height: 44))
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: -8, width: 62, height: 44)
        button.setBackgroundImage(#imageLiteral(resourceName: "ic_logo"), for: .normal)
        buttonContainer.addSubview(button)
//        navigationController.navigationItem.titleView = buttonContainer
        UINavigationBar.appearance().addSubview(buttonContainer)
    }
}

extension UINavigationController {
    @objc override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

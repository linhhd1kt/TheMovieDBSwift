//
//  ViewControllerWithSideMenu.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 19/10/2022.
//

import Foundation
import UIKit
import SideMenu

class ViewControllerWithSideMenu: BaseViewController {
    var panGesture = UIPanGestureRecognizer()
    var edgeGesture = UIScreenEdgePanGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        panGesture = SideMenuManager.default.addPanGestureToPresent(toView: navigationController!.navigationBar)
        edgeGesture = SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: navigationController!.view, forMenu: .left)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enableSideMenu()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        disableSideMenu()
    }
    
    func disableSideMenu() {
        panGesture.isEnabled = false
        edgeGesture.isEnabled = false
    }
    
    func enableSideMenu() {
        panGesture.isEnabled = true
        edgeGesture.isEnabled = true
    }
    
    func showSideMenu() {
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
}


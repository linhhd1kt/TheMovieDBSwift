//
//  RickViewController.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 19/10/2022.
//

import Foundation
import UIKit
import RxSwift
import SideMenu
import RxCocoa

class RickViewController: BaseViewController {
    // MARK: - Gesture
    var panGesture = UIPanGestureRecognizer()
    var edgeGesture = UIScreenEdgePanGestureRecognizer()
    
    // MARK: - Navigation item
    var menuNavigationItem: UIBarButtonItem
    var logoNavigationItem: UIButton
    var profileNavigationItem: UIBarButtonItem
    var searchNavigationItem: UIBarButtonItem
    
    let navigationViewModel: NavigationViewModelType
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(navigationItemFactory: NavigationItemCreatable = NavigationItemFactory(),
         navigationViewModel: NavigationViewModelType) {
        menuNavigationItem = navigationItemFactory.makeNavigationItem(.menu)
        logoNavigationItem = navigationItemFactory.makeLogoButton()
        profileNavigationItem = navigationItemFactory.makeNavigationItem(.profile)
        searchNavigationItem = navigationItemFactory.makeNavigationItem(.search)
        self.navigationViewModel = navigationViewModel
        super.init()
        logger.debug("\(className) is initialized.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGesture()
        setupNavigationItem()
        bindNavigationInput(navigationViewModel.input)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enableSideMenu()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        disableSideMenu()
    }
    
    private func bindNavigationInput(_ input: NavigationViewModelInputType) {
        ControlEvent.merge(
            menuNavigationItem.rx.tap.map { DrawerMenuScreen.menu },
            logoNavigationItem.rx.tap.map { DrawerMenuScreen.dashboard },
            profileNavigationItem.rx.tap.map { DrawerMenuScreen.profile },
            searchNavigationItem.rx.tap.map { DrawerMenuScreen.search }
            )
            .bind(to: navigationViewModel.input.navigationSelect)
            .disposed(by: disposeBag)
    }
    
    private func setupGesture() {
        if let navigationbar = navigationController?.navigationBar {
            panGesture = SideMenuManager.default.addPanGestureToPresent(toView: navigationbar)
        }
        if let view = navigationController?.view {
        edgeGesture = SideMenuManager.default
                .addScreenEdgePanGesturesToPresent(toView: view, forMenu: .left)
        }
    }

    private func setupNavigationItem() {
        navigationItem.leftBarButtonItem = menuNavigationItem
        navigationItem.titleView = logoNavigationItem
        navigationItem.rightBarButtonItems = [searchNavigationItem, profileNavigationItem]
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
        guard let leftMenu = SideMenuManager.default.leftMenuNavigationController else {
            return
        }
        present(leftMenu, animated: true, completion: nil)
    }
}

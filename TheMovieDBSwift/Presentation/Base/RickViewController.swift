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
    
    private let profileAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    private let navigationViewModel: NavigationViewModelType
    
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
        setupPopUp()
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
            menuNavigationItem.rx.tap.map { Screen.menu },
            logoNavigationItem.rx.tap.map { Screen.dashboard },
            searchNavigationItem.rx.tap.map { Screen.search }
        )
        .bind(to: navigationViewModel.input.navigationSelect)
        .disposed(by: disposeBag)
        
        profileNavigationItem.rx.tap
            .withUnretained(self)
            .subscribe { this, _ in
                this.present(this.profileAlert, animated: true)
            }
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
    
    private func setupPopUp() {
        let loginAction = UIAlertAction(title: "Login", style: .default) { [weak self] _ in
            self?.navigationViewModel.input.navigationSelect.onNext(.signIn)
        }
        let signUpAction = UIAlertAction(title: "Sign Up", style: .default) { [weak self] _ in
            self?.navigationViewModel.input.navigationSelect.onNext(.signUp)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
        profileAlert.addAction(loginAction)
        profileAlert.addAction(signUpAction)
        profileAlert.addAction(cancelAction)
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

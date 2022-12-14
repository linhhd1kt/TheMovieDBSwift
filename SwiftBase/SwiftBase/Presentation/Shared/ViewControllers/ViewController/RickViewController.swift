//
//  RickViewController.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Domain
import RxCocoa
import RxSwift
import Services
import SideMenu
import Extension
import Data

open class RickViewController: BaseViewController {
  // MARK: - Gesture
  var panGesture = UIPanGestureRecognizer()
  var edgeGesture = UIScreenEdgePanGestureRecognizer()
  // MARK: - Navigation item
//  private let menuNavigationItem: UIBarButtonItem
//  private let logoNavigationItem: UIButton
//  private let profileNavigationItem: UIBarButtonItem
//  private let searchNavigationItem: UIBarButtonItem
  
  private let profileAlert = UIAlertController(title: nil,
                                               message: nil,
                                               preferredStyle: .actionSheet)
  private let navigationViewModel: NavigationViewModelType
  
  public required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public init(navigationViewModel: NavigationViewModelType) {
    self.navigationViewModel = navigationViewModel
    super.init()
  }
  
  override open func viewDidLoad() {
    super.viewDidLoad()
    setupGesture()
    setupNavigationItem()
    setupPopUp()
    bindNavigationInput(navigationViewModel.input)
  }
  
  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    enableSideMenu()
  }
  
  public override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(true)
    disableSideMenu()
  }
  
  private func bindNavigationInput(_: NavigationViewModelInputType) {
//    ControlEvent.merge(
//      menuNavigationItem.rx.tap.map { Screen.menu },
//      logoNavigationItem.rx.tap.map { Screen.dashboard },
//      searchNavigationItem.rx.tap.map { Screen.search }
//    )
//    .bind(to: navigationViewModel.input.navigationSelect)
//    .disposed(by: disposeBag)
//
//    profileNavigationItem.rx.tap
//      .withUnretained(self)
//      .subscribe { this, _ in
//        this.present(this.profileAlert, animated: true)
//      }
//      .disposed(by: disposeBag)
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
//    navigationItem.leftBarButtonItem = menuNavigationItem
//    navigationItem.titleView = logoNavigationItem
//    navigationItem.rightBarButtonItems = [searchNavigationItem, profileNavigationItem]
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

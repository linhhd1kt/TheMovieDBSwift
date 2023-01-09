//
//  NavigationViewModel.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import RxSwift
import Design
import Domain
import Data

public final class NavigationViewModel: BaseViewModel {
  // MARK: - Dependency

  // MARK: - Input

  private let navigationMenuObserver = BehaviorSubject<Screen>(value: .dashboard)

  // MARK: - Output

  private let navigationSelectedObserver = BehaviorSubject<Screen>(value: .dashboard)
  private let menuItemsObserver = BehaviorSubject<[Screen]>(value: Screen.displayItems)

  override public init() {
    super.init()
    binding()
  }

  private func binding() {
    navigationMenuObserver
      .bind(to: navigationSelectedObserver)
      .disposed(by: disposeBag)
  }
}

extension NavigationViewModel: NavigationViewModelType {
  public var input: NavigationViewModelInputType {
    return self
  }

  public var output: NavigationViewModelOutputType {
    return self
  }
}

extension NavigationViewModel: NavigationViewModelInputType {
  public var navigationSelect: AnyObserver<Screen> {
    return navigationMenuObserver.asObserver()
  }
}

extension NavigationViewModel: NavigationViewModelOutputType {
  public var navigationSelected: Observable<Screen> {
    return navigationSelectedObserver.asObservable()
  }

  public var menuItems: Observable<[Screen]> {
    return menuItemsObserver.asObservable()
  }
}

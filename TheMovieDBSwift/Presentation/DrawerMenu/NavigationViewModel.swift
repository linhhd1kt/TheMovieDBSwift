//
//  NavigationViewModel.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 18/10/2022.
//

import RxSwift

final class NavigationViewModel: BaseViewModel {
    // MARK: - Dependency
    
    // MARK: - Input
    private let navigationMenuObserver = BehaviorSubject<DrawerMenuScreen>(value: .dashboard)

    // MARK: - Output
    private let navigationSelectedObserver = BehaviorSubject<DrawerMenuScreen>(value: .dashboard)
    private let menuItemsObserver = BehaviorSubject<[DrawerMenuScreen]>(value: DrawerMenuScreen.displayItems)
    override init() {
        super.init()
        self.binding()
    }

    private func binding() {
        navigationMenuObserver
            .bind(to: navigationSelectedObserver)
            .disposed(by: disposeBag)
    }
}

extension NavigationViewModel: NavigationViewModelType {
    var input: NavigationViewModelInputType {
        return self
    }
    var output: NavigationViewModelOutputType {
        return self
    }
}

extension NavigationViewModel: NavigationViewModelInputType {
    var navigationSelect: AnyObserver<DrawerMenuScreen> {
        return navigationMenuObserver.asObserver()
    }
}

extension NavigationViewModel: NavigationViewModelOutputType {
    var navigationSelected: Observable<DrawerMenuScreen> {
        return navigationSelectedObserver.asObservable()
    }
    var menuItems: Observable<[DrawerMenuScreen]> {
        return menuItemsObserver.asObservable()
    }
}

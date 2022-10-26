//
//  NavigationViewModelType.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 18/10/2022.
//

import RxSwift

protocol NavigationViewModelType {
    var input: NavigationViewModelInputType { get }
    var output: NavigationViewModelOutputType { get }
}

protocol NavigationViewModelInputType {
    var navigationSelect: AnyObserver<DrawerMenuScreen> { get }
}

protocol NavigationViewModelOutputType {
    var navigationSelected: Observable<DrawerMenuScreen> { get }
    var menuItems: Observable<[DrawerMenuScreen]>  { get }
}


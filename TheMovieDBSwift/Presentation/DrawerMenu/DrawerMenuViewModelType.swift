//
//  DrawerMenuViewModelType.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 18/10/2022.
//

import RxSwift

protocol DrawerMenuViewModelType {
    var input: DrawerMenuViewModelInputType { get }
    var output: DrawerMenuViewModelOutputType { get }
}

protocol DrawerMenuViewModelInputType {
    var menuSelect: AnyObserver<DrawerMenuScreen> { get }
}

protocol DrawerMenuViewModelOutputType {
    var menuSelected: Observable<DrawerMenuScreen> { get }
    var menuItems: Observable<[DrawerMenuScreen]>  { get }
}


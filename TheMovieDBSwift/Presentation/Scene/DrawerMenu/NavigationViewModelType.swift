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
    var navigationSelect: AnyObserver<Screen> { get }
}

protocol NavigationViewModelOutputType {
    var navigationSelected: Observable<Screen> { get }
    var menuItems: Observable<[Screen]> { get }
}

//
//  CategoryDropdownType.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 11/11/2022.
//

import RxSwift

protocol CategoryDropdownInput {
    var categoryList: AnyObserver<[PopularCategory]> { get }
}

protocol CategoryDropdownOutput {
    var selectedPopularCategory: Observable<PopularCategory> { get }
}

//
//  RickTableViewType.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 09/11/2022.
//

import Foundation
import RxSwift

protocol RickTableViewInputType {
    associatedtype Page
    var itemsResult: AnyObserver<Page> { get }
}

protocol RickTableViewOutputType {
    var nextPageTrigger: Observable<Int> { get }
}

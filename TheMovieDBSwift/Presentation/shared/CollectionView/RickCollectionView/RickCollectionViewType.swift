//
//  RickCollectionViewType.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 09/11/2022.
//

import Foundation
import RxSwift

protocol RickCollectionViewInputType {
    associatedtype Page
    var itemsResult: AnyObserver<Page> { get }
    var reset: AnyObserver<Void> { get }
}

protocol RickCollectionViewOutputType {
    var nextPageTrigger: Observable<Int> { get }
}

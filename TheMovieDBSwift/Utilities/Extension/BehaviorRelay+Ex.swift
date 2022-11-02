//
//  BehaviorRelay+Ex.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 02/11/2022.
//

import RxCocoa
import RxSwift

extension BehaviorRelay where Element: Paginated {
    var append: AnyObserver<Element> {
        AnyObserver { [weak self] event in
            guard let self = self else {
                return
            }
            switch event {
            case .next(let data):
                var newValue = self.value
                newValue.page = data.page
                newValue.totalPages = data.totalPages
                newValue.totalResults = data.totalResults
                newValue.results += data.results
                self.accept(newValue)
            default:
                break
            }
        }
    }
}

//
//  DataSource.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 29/09/2022.
//

import Foundation
import RxSwift

protocol DataSource {
    associatedtype T: Decodable & Identifiable
    func get(id: String?, parameters: [String: Any]) -> Observable<T?>
    func save(entity: T) -> Observable<Void>
}

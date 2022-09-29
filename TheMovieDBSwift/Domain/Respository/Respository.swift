//
//  Respository.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 29/09/2022.
//

import Foundation
import RxSwift

protocol Respository {
    associatedtype T: Decodable & Identifiable
    func get(id: String?, parameters: Dictionary<String, Any>) -> Observable<T?>
    func save(entity: T) -> Observable<Void>
}

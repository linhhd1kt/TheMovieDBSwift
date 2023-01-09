//
//  DataSourceType.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Foundation
import RxSwift

public protocol DataSourceType {
  associatedtype T: Decodable & Identifiable
  func get(id: String?, parameters: [String: Any]) -> Observable<T?>
  func save(entity: T) -> Observable<Void>
}

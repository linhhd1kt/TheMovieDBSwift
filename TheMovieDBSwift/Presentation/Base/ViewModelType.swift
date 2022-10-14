//
//  ViewModelType.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 10/10/2022.
//

import Foundation

protocol ViewModelType {
    associatedtype InputType
    associatedtype OutputType
    func transform(input: InputType) -> OutputType
}

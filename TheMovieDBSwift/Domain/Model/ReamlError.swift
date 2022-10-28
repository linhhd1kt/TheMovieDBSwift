//
//  NetworkError.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 26/08/2022.
//

import Foundation

enum LocalError: Error {
    case some(description: String)
}

extension LocalError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .some(let description):
            return NSLocalizedString("Local Error: \(description)", comment: "Local Error")
        }
    }
}

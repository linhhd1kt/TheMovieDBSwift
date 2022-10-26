//
//  NetworkError.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 26/08/2022.
//

import Foundation

enum LocalError: Error {
    //TODO: detail network error here
    case some(description: String)
}

extension LocalError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .some(let description):
            //TODO: load error from localized string file here
            return NSLocalizedString("Local Error: \(description)", comment: "Local Error")
        }
    }
}




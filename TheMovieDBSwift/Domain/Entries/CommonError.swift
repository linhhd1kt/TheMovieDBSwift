//
//  AppError.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 26/08/2022.
//

import Foundation

enum CommonError: Error {
    case system
    case missingImplement(type: String)
    case decode(description: String)
}


extension CommonError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .system:
            //TODO: load error from localized string file here
            return NSLocalizedString("Some System error occur!", comment: "System Error!")
        case .missingImplement(let type):
            return NSLocalizedString("\(type): missing implement!", comment: "Missing Implement!")
        case .decode(let description):
            return NSLocalizedString("Decode error: \(description)", comment: "Decde Error!")
        }
    }
}



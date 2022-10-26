//
//  NetworkError.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 26/08/2022.
//

import Foundation

enum NetworkError: Error {
    case informationalResponse
    case redirectionMessages
    case client(code: Int, message: String)
    case server(code: Int, message: String)
    case invalidReponse(message: String)
    case connection(message: String)
    case other(message: String)
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .informationalResponse:
            return NSLocalizedString("Network Error: Not handle server informational reponses",
                                     comment: "Network Error")
        case .redirectionMessages:
            return NSLocalizedString("Network Error: Not handle server redirection messages reponses",
                                     comment: "Network Error")
        case .client(let code, let message):
            return NSLocalizedString("Client Error with status code: \(code), message: \(message)",
                                     comment: "Network Error")
        case .server(let code, let message):
            return NSLocalizedString("Server Error with status code: \(code), message: \(message)",
                                     comment: "Network Error")
        case .invalidReponse(let message):
            return NSLocalizedString("Invalid Response: \(message)",
                                     comment: "Network Error")
        case .connection(message: let message):
            return NSLocalizedString("Connection Error: \(message)",
                                     comment: "Network Error")
        case .other(let message):
            return NSLocalizedString("Network Error: \(message)",
                                     comment: "Network Error")
        }
    }
    public var statusCode: Int? {
        switch self {
        case .client(let code, _), .server(let code, _):
            return code
        default:
            return nil
        }
    }
}




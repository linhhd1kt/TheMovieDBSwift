//
//  PaceBoxError.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Foundation

public enum NetworkError: Error {
  case system
  case missingImplement(type: String)
  case decode(code: Int)
  case informationalResponse
  case redirectionMessages
  case client(code: Int, message: String)
  case server(code: Int, message: String)
  case invalidReponse(code: Int)
  case connection(message: String)
  case maintain
  case other(message: String)
}

extension NetworkError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .system:
      return NSLocalizedString("Some System error occur!", comment: "System Error!")
    case let .missingImplement(type):
      return NSLocalizedString("\(type): missing implement!", comment: "Missing Implement!")
    case let .decode(code):
      return NSLocalizedString("Decode error with code: \(code)", comment: "Decode Error!")
    case .informationalResponse:
      return NSLocalizedString("Network Error: Not handle server informational reponses",
                               comment: "Network Error")
    case .redirectionMessages:
      return NSLocalizedString("Network Error: Not handle server redirection messages reponses",
                               comment: "Network Error")
    case let .client(code, message):
      return NSLocalizedString(message, comment: "Network Error")
    case let .server(code, message):
      return NSLocalizedString(message, comment: "Network Error")
    case let .invalidReponse(code):
      return NSLocalizedString("Response data not mapping model with: \(code)", comment: "Network Error - Data mapping")
    case let .connection(message: message):
      return NSLocalizedString(message, comment: "Network Error")
    case .maintain:
      return NSLocalizedString("Server maintain", comment: "Network Error")
    case let .other(message):
      return NSLocalizedString(message, comment: "Network Error")
    }
  }

  public var statusCode: Int? {
    switch self {
    case let .client(code, _), let .server(code, _):
      return code
    default:
      return nil
    }
  }
}

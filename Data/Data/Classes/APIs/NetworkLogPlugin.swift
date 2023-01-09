//
//  NetworkLogPlugin.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Moya
import SwiftPrettyPrint
import Extension
import Services

public final class NetworkLogPlugin: PluginType {
  private let logger: Logable
  private var requestLogMessage: String = ""
  
  public init(logger: Logable) {
    self.logger = logger
  }
  
  public func willSend(_ request: RequestType, target: TargetType) {
    let decoratedPath = "\(target.method.rawValue) \(target.baseURL.appendingPathComponent(target.path).absoluteString)"
    if let body = request.request?.httpBody {
      logger.debug("""
                   \n\n🇻🇳🇻🇳🇻🇳 REQUEST START API_ \(decoratedPath)
                    \(String(decoding: body, as: UTF8.self))
                   """,
                   functionName: #function,
                   fileName: #file,
                   lineNumber: #line)
    } else {
      logger.debug("\n\n🇻🇳🇻🇳🇻🇳 REQUEST START API_ \(decoratedPath)",
                   functionName: #function,
                   fileName: #file,
                   lineNumber: #line)
    }
  }
  
  public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
    let decoratedPath = "\(target.method.rawValue) \(target.baseURL.appendingPathComponent(target.path).absoluteString)"
    switch result {
    case .success(let response):
      logger.debug("\n\n🇻🇳🇻🇳🇻🇳 RESPONSE SUCCESS API_ \(decoratedPath)",
                   functionName: #function,
                   fileName: #file,
                   lineNumber: #line)
      if let json = try? JSONSerialization.jsonObject(with: response.data, options: .mutableContainers) as? [String: Any] {
        if logger.getLogLevel().rawValue < LogLevel.debug.rawValue {
          if let page = json["page"] as? Int,
             let results = json["results"] as? [Any],
             let totalPages = json["total_pages"] as? Int,
             let totalResults = json["total_results"] as? Int {
            Pretty.prettyPrint([
              "page": page,
              "results": results.count,
              "total_pages": totalPages,
              "total_results": totalResults,
              "short_item": results.first ?? ""
            ])
          } else {
            Pretty.prettyPrint(json)
          }
        }
      } else {
        if let responseString = String(data: response.data, encoding: .utf8) {
          if logger.getLogLevel().rawValue < LogLevel.debug.rawValue {
            Pretty.prettyPrint(responseString)
          }
        }
      }
    case .failure(let error):
      logger.debug("\n\n🇻🇳🇻🇳🇻🇳 RESPONSE ERROR API_ \(decoratedPath): \(error.localizedDescription)",
                   functionName: #function,
                   fileName: #file,
                   lineNumber: #line)
    }
  }
}

extension Data {
  var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
    guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
          let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
          let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
    return prettyPrintedString
  }
}

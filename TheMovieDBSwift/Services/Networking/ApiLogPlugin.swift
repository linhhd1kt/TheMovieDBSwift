//
//  ApiLogPlugin.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 20/10/2022.
//

import Moya
import Foundation
import SwiftPrettyPrint

final class ApiLogPlugin: PluginType {
    var logger: Logger {
        guard let logger = ServiceFacade.getService(Logable.self) as? Logger else {
            fatalError("Logger should be implemented!")
        }
        return logger
    }
    
    var requestLogMessage: String = ""
    
    func willSend(_ request: RequestType, target: TargetType) {
        let decoratedPath = "\(target.method.rawValue) \(target.baseURL.appendingPathComponent(target.path).absoluteString)"
        if let body =  request.request?.httpBody {
            logger.verbose("""
                        \n\n🇻🇳🇻🇳🇻🇳 REQUEST START API_ \(decoratedPath)
                         \(String(decoding: body, as: UTF8.self))\n
                        """)
        } else {
            logger.verbose("\n\n🇻🇳🇻🇳🇻🇳 REQUEST START API_ \(decoratedPath)\n")
        }
    }

    func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        let decoratedPath = "\(target.method.rawValue) \(target.baseURL.appendingPathComponent(target.path).absoluteString)"
        switch result {
        case .success(let response):
            logger.verbose("\n\n🇻🇳🇻🇳🇻🇳 RESPONSE SUCCESS API_ \(decoratedPath)")
            if let json = try? JSONSerialization.jsonObject(with: response.data, options: .mutableContainers) as? [String: Any] {
                Pretty.prettyPrint(json)
            } else {
                let responseString = String(data: response.data, encoding: .utf8)!
                Pretty.prettyPrint(responseString)
            }
        case .failure(let error):
            logger.verbose("\n\n🇻🇳🇻🇳🇻🇳 RESPONSE ERROR API_ \(decoratedPath): \(error.localizedDescription)")
        }
    }
}

//
//  ResponseParser.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 26/09/2022.
//

import Foundation
import Moya

protocol ResponseParsable {
    func parseError(response: Response) -> Error?
}

struct NetworkReponse: Decodable {
    let statusCode: Int
    let statusMessage: String
    let success: Bool
}

class ResponseParser: ResponseParsable {
    private let decoder: JSONDecoder
    
    init() {
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func parseError(response: Response) -> Error? {
        switch response.statusCode {
        case 100...199: // Informational responses
            return NetworkError.informationalResponse
        case 200...299: // not have error
            return nil
        case 300...399:
            return NetworkError.redirectionMessages
        case 400...499:
            do {
                let networkResponse = try decoder.decode(NetworkReponse.self, from: response.data)
                return NetworkError.client(code: networkResponse.statusCode,
                                           message: networkResponse.statusMessage)
            }
            catch {
                return CommonError.decode(description: error.localizedDescription)
            }
        case 500...599:
            do {
                let networkResponse = try JSONDecoder().decode(NetworkReponse.self, from: response.data)
                return NetworkError.server(code: networkResponse.statusCode,
                                           message: networkResponse.statusMessage)


            }
            catch {
                return CommonError.decode(description: error.localizedDescription)
            }
        default:
            return NetworkError.other(message
                                      : "Http status code unhandle: \(response.statusCode)")
        }
    }
}

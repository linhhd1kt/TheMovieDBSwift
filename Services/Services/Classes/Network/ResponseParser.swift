//
//  ResponseParser.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Foundation
import Moya
import RxSwift

public protocol ResponseParserType {
  func parseJson<T: Codable>(data: Data, statusCode: Int, ofType: T.Type) -> Result<T?, Error>
}

public class ServerError: Decodable, LocalizedError {
  public enum CodingKeys: String, CodingKey {
    case statusCode = "status_code"
    case statusMessage = "status_message"
    case success = "success"
  }
  public let statusCode: Int
  public let statusMessage: String
  public let success: Bool
  
  public var errorDescription: String? {
    return statusMessage
  }
  
  public required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    statusCode = (try? container.decode(Int.self, forKey: .statusCode)) ?? 0
    statusMessage = (try? container.decode(String.self, forKey: .statusMessage)) ?? "Wrong message"
    success = (try? container.decode(Bool.self, forKey: .success)) ?? false
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try? container.encode(statusCode, forKey: .statusCode)
    try? container.encode(statusMessage, forKey: .statusMessage)
    try? container.encode(success, forKey: .success)
  }
}

public final class ResponseParser: ResponseParserType {
  private let decoder: DataDecoder
  
  public init(decoder: DataDecoder = JSONDecoder()) {
    self.decoder = decoder
  }
  
  public func parseJson<T: Codable>(data: Data, statusCode: Int, ofType _: T.Type) -> Result<T?, Error> {
    switch statusCode {
    case 100 ... 199:
      return .failure(NetworkError.informationalResponse)
    case 200 ... 299:
      do {
        let result = try decoder.decode(T.self, from: data)
        return .success(result)
      } catch {
        return .failure(NetworkError.decode(code: statusCode))
      }
    case 300 ... 399:
      return .failure(NetworkError.redirectionMessages)
    case 400 ... 499:
      do {
        let serverError = try decoder.decode(ServerError.self, from: data)
        return .failure(serverError)
      } catch {
        return .failure(NetworkError.decode(code: statusCode))
      }
    case 500 ... 599:
      // checking for server maitain case
      if statusCode == 503 {
        return .failure(NetworkError.maintain)
      }
      do {
        let serverError = try decoder.decode(ServerError.self, from: data)
        return .failure(serverError)
      } catch {
        return .failure(NetworkError.decode(code: statusCode))
      }
    default:
      return .failure(NetworkError.other(message: "https status code unhandle: \(statusCode)"))
    }
  }
}

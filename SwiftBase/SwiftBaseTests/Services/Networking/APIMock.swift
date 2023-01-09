//
//  APIMock.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Data
import Moya
import Services
@testable import SwiftBase

public enum APITargetMock {
  case invalidResponse
  case emptyResponse
  case failureResponse
  case successResponse
}

public class APIMock: TargetType {
  private let target: APITargetMock

  public var baseURL: URL = TestEnvironment().baseUrl

  public var path: String {
    return ""
  }

  public var method: Moya.Method {
    return .get
  }

  public var sampleData: Data {
    switch target {
    case .invalidResponse:
      return DummyResponse.invalidData
    case .emptyResponse:
      return DummyResponse.emptyData
    case .failureResponse:
      return DummyResponse.failureData
    case .successResponse:
      return DummyResponse.successData
    }
  }

  public var task: Task {
    return .requestParameters(parameters: [:], encoding: URLEncoding.httpBody)
  }

  public var headers: [String: String]? {
    return nil
  }

  public init(target: APITargetMock) {
    self.target = target
  }
}

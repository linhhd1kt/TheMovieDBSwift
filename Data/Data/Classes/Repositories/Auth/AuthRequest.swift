//
//  AuthRequest.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Moya
import Services

public struct CredentialRequest {
  public let username: String
  public let password: String
  public let requestToken: String

  public init(username: String, password: String, requestToken: String) {
    self.username = username
    self.password = password
    self.requestToken = requestToken
  }
}

extension CredentialRequest: ApiRequestType {
  public func toTarget(baseUrl: URL, apiKey: String) -> TargetType {
    let parameters = ["username": username,
                      "password": password,
                      "request_token": requestToken]
    return API(baseURL: baseUrl,
               target: .createSessionWithLogin(parameters: parameters),
               apiKey: apiKey)
  }
}

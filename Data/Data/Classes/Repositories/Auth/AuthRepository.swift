//
//  AuthRepository.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Action
import Services

public protocol AuthRepositoryType {
  var login: Action<CredentialRequest, CredentialResponse> { get }
}

public final class AuthRepository: AuthRepositoryType {
  public let login: Action<CredentialRequest, CredentialResponse>

  public init(network: Networking) {
    login = Action { input in
      network.request(target: API(baseURL: network.endPoint,
                                  target: .createSessionWithLogin(parameters: ["username": input.username,
                                                                               "password": input.password,
                                                                               "request_token": input.requestToken]),
                                  apiKey: network.apiKey))
    }
  }
}

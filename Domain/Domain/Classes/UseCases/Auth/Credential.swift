//
//  Credential.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

public struct Credential {
  public let success: Bool
  public let expiresAt: String?
  public let requestToken: String?

  public static var `default`: Credential {
    return Credential(success: false, expiresAt: nil, requestToken: nil)
  }

  public init(success: Bool, expiresAt: String?, requestToken: String?) {
    self.success = success
    self.expiresAt = expiresAt
    self.requestToken = requestToken
  }
}

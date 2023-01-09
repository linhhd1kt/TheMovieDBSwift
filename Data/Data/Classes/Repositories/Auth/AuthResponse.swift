//
//  AuthResponse.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

public struct CredentialResponse: Codable {
  enum CodingKeys: String, CodingKey {
    case success
    case expiresAt = "expires_at"
    case requestToken = "request_token"
  }
  public let success: Bool
  public let expiresAt: String?
  public let requestToken: String?
  
  public init(success: Bool, expiresAt: String?, requestToken: String?) {
    self.success = success
    self.expiresAt = expiresAt
    self.requestToken = requestToken
  }
}

extension CredentialResponse: Equatable {
  public static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.success == rhs.success
    && lhs.expiresAt == rhs.expiresAt
    && lhs.requestToken == rhs.requestToken
  }
}

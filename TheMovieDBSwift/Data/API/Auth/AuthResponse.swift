//
//  AuthResponse.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 11/10/2022.
//

import Foundation

struct CredentialResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
    let success: Bool
    let expiresAt: String?
    let requestToken: String?
}

//
//  AuthResponse.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 11/10/2022.
//

import Foundation

struct CredentialResponse: Decodable {
    let success: Bool
    let expiresAt: String?
    let requestToken: String?
}

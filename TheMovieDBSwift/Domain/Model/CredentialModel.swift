//
//  Credential.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 11/10/2022.
//

import Foundation

struct CredentialModel {
    let success: Bool?
    let expiresAt: String?
    let requestToken: String?
    
    static var `default`: CredentialModel {
        return CredentialModel(success: nil, expiresAt: nil, requestToken: nil)
    }
}

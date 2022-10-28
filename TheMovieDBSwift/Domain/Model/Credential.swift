//
//  Credential.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 11/10/2022.
//

import Foundation

struct Credential {
    let success: Bool
    let expiresAt: String?
    let requestToken: String?
    
    static var `default`: Credential {
        return Credential(success: false, expiresAt: nil, requestToken: nil)
    }
}

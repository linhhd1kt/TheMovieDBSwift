//
//  Credential.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 26/08/2022.
//

import Foundation
import RealmSwift

class Credential: Object, Identifiable, Codable {
    @objc dynamic var success: Bool
    @objc dynamic var expiresAt: String
    @objc dynamic var requestToken: String
    override static func primaryKey() -> String? {
        return "requestToken"
    }
}

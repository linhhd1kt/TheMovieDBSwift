//
//  AuthRepositotyType.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 11/10/2022.
//

import Action

protocol AuthRepositoryType {
    var login: Action<CredentialRequest, CredentialResponse> { get }
}

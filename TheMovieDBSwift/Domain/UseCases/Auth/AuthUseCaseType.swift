//
//  AuthUseCaseType.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 26/08/2022.
//

import RxSwift

protocol AuthUseCaseType {
    var input: AuthUseCaseInputType { get }
    var output: AuthUseCaseOutputType { get }
}

protocol AuthUseCaseInputType {
    var login: AnyObserver<(email: String, password: String)> { get }
}

protocol AuthUseCaseOutputType {
    var loginResult: ActionResult<CredentialModel> { get }
}

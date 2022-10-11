//
//  LoginViewModelType.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 10/10/2022.
//

import RxSwift

protocol LoginViewModelType {
    var input: LoginViewModelInputType { get }
    var output: LoginViewModelOutputType { get }
}

protocol LoginViewModelInputType {
    var username: AnyObserver<String> { get }
    var password: AnyObserver<String> { get }
    var loginAction: AnyObserver<Void> { get }
    var forgotPasswordAction: AnyObserver<Void> { get }
    var registerAction: AnyObserver<Void> { get }
}

protocol LoginViewModelOutputType {
    var credential: ActionResult<CredentialModel>  { get }
    var error: Observable<String> { get }
    var loginButtonEnabled: Observable<Bool> { get }
}


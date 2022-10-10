//
//  LoginViewModelType.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 10/10/2022.
//

import Foundation
import RxSwift
import RxCocoa

struct LoginInfo {
    let username: String
    let password: String
}

protocol LoginViewModelInputType {
    var username: PublishSubject<String?> { get set }
    var password: PublishSubject<String?> { get set }
    var loginAction: PublishSubject<Void> { get set }
    var forgotPasswordAction: PublishSubject<Void> { get set }
    var registerAction: PublishSubject<Void> { get set }
}

protocol LoginViewModelOutputType {
    var result: Driver<Credential?> { get set }
}

protocol LoginViewModeltype {
    func transform(input: LoginViewModelInputType) -> LoginViewModelOutputType
}

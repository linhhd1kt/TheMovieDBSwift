//
//  AuthUseCase.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 09/09/2022.
//

import RxSwift
import NSObject_Rx

class AuthUseCase {
    // MARK: - Dependency
    private let respository: AuthRepositoryType
    private let traslator: AuthTranslatorType
    // MARK: - Input
    private let loginObserver = PublishSubject<(email: String, password: String)>()
    // MARK: - Other
    
    init(respository: AuthRepositoryType, translator: AuthTranslatorType = AuthTranslator()) {
        self.respository = respository
        self.traslator = translator
        bindInput()
    }

    private func bindInput() {
        loginObserver
            .map { [unowned self] in self.traslator.toRequest(username: $0, password: $1, requestToken: "") }
            .bind(to: respository.login.inputs)
            .disposed(by: disposeBag)
    }
}

// MARK: - AuthUseCaseType
extension AuthUseCase: AuthUseCaseType {
    var input: AuthUseCaseInputType { return self }
    var output: AuthUseCaseOutputType { return self }
}

// MARK: - AuthUseCaseInputType
extension AuthUseCase: AuthUseCaseInputType {
    var login: AnyObserver<(email: String, password: String)> {
        return loginObserver.asObserver()
    }
}

// MARK: - AuthUseCaseOutputType
extension AuthUseCase: AuthUseCaseOutputType {
    var loginResult: ActionResult<Credential> {
        return respository.login.toResult().map { self.traslator.toModel(reponse: $0)}
    }
}

extension AuthUseCase: HasDisposeBag {}

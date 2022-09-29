//
//  DefaultAuthUseCase.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 09/09/2022.
//

import Foundation
import RxSwift

final class DefaultAuthUseCase<R>: AuthUseCase where R: Respository, R.T == Credential {
    let respository: R
    
    init(respository: R) {
        self.respository = respository
    }
    
    func login(username: String?, password: String?) -> Observable<Credential?> {
        guard let password = password, let username = username else {
            fatalError("Need implement validator for username password!")
        }
        return respository.get(id: username, parameters: ["username": username, "password": password])            
    }
}

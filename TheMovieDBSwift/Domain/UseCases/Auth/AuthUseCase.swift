//
//  AuthUseCase.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 26/08/2022.
//

import RxSwift

protocol AuthUseCase {
    func login(username: String?, password: String?) -> Observable<Credential?>
}

//
//  AuthUseCaseTest.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Nimble
import Quick
import RxSwift
import RxTest
import Domain
import Services
import Action
import Data

@testable import SwiftBase

class AuthUseCaseSpec: QuickSpec {
  override func spec() {
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    var sut: AuthUseCase!
    var errorRepositoryMock: AuthRepositoryType!
    var successrepositoryMock: AuthRepositoryType!
    var authTranslatorMock: AuthTranslatorType!

    describe("Authenticate usecase") {
      beforeEach {
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        authTranslatorMock = AuthTranslatorMock()
        errorRepositoryMock = AuthRepositoryErorrResponseMock()
        successrepositoryMock = AuthRepositorySuccessResponseMock()
      }

      context("test login executing") {
        it("shound executing when request") {
          let email = "mail@dummy.com"
          let password = "dummy-password"

          sut = AuthUseCase(repository: successrepositoryMock, translator: authTranslatorMock)

          typealias Info = (companyCode: String, email: String, password: String)
          let loginExecuting = scheduler.createObserver(Bool.self)

          sut.loginResult.executing
            .bind(to: loginExecuting)
            .disposed(by: disposeBag)

          scheduler.createColdObservable([
            .next(0, (email, password)),
          ])
          .bind(to: sut.login)
          .disposed(by: disposeBag)

          scheduler.start()

          expect(loginExecuting.events).toEventually(equal([
            .next(0, false),
            .next(0, true),
            .next(0, false),
          ]))
        }
      }

      context("test login error") {
        it("shound return error") {
          let email = "mail@dummy.com"
          let password = "dummy-password"

          sut = AuthUseCase(repository: errorRepositoryMock, translator: authTranslatorMock)

          typealias Info = (email: String, password: String)
          let loginResult = scheduler.createObserver(ActionError.self)

          sut.loginResult.errors
            .bind(to: loginResult)
            .disposed(by: disposeBag)

          scheduler.createColdObservable([
            .next(0, (email, password)),
          ])
          .bind(to: sut.login)
          .disposed(by: disposeBag)

          scheduler.start()

          expect(loginResult.events).toEventually(equal([
            .next(0, ActionError.underlyingError(AuthRepositoryResponseError.logicError)),
          ]))
        }
      }

      context("test login success") {
        it("should return user info after login") {
          let email = "mail@dummy.com"
          let password = "dummy-password"

          sut = AuthUseCase(repository: successrepositoryMock, translator: authTranslatorMock)

          typealias Info = (companyCode: String, email: String, password: String)
          let loginResult = scheduler.createObserver(Credential.self)

          sut.loginResult.elements
            .bind(to: loginResult)
            .disposed(by: disposeBag)

          scheduler.createColdObservable([
            .next(0, (email, password)),
          ])
          .bind(to: sut.login)
          .disposed(by: disposeBag)

          scheduler.start()

          expect(loginResult.events).toEventually(equal([
            .next(0, Credential(success: true, expiresAt: nil, requestToken: nil)),
          ]))
        }
      }
    }
  }
}

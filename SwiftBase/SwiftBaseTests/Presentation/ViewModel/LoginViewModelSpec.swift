//
//  LoginViewModelSpec.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Action
import Nimble
import Quick
import RxSwift
import RxTest
import Domain
import Services
import Data

@testable import SwiftBase

class LoginViewModelSpec: QuickSpec {
  override func spec() {
    var scheduler: TestScheduler!
    var disposedBag: DisposeBag!
    var successAuthUseCaseMock: AuthUseCaseType!
    var errorAuthUseCaseMock: AuthUseCaseType!
    var sut: LoginViewModel!
    
    describe("Test Login view model") {
      beforeEach {
        disposedBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
        successAuthUseCaseMock = SuccessAuthUseCaseMock()
        errorAuthUseCaseMock = ErrorAuthUseCaseMock()
      }
      
      context("when not enough input username, password") {
        it("should not enable login button") {
          let username = "dummy-username"
          let password = "dummy-password"
          
          sut = LoginViewModel(usecase: successAuthUseCaseMock)
          let loginButonEnabled = scheduler.createObserver(Bool.self)
          
          scheduler.createColdObservable([.next(0, username)])
            .bind(to: sut.input.username)
            .disposed(by: disposedBag)
          scheduler.createColdObservable([.next(0, password)])
            .bind(to: sut.input.password)
            .disposed(by: disposedBag)
          sut.output.loginResult.enabled
            .bind(to: loginButonEnabled)
            .disposed(by: disposedBag)
          
          scheduler.start()
          
          expect(loginButonEnabled.events).toEventually(equal([
            .next(0, false)
          ]))
        }
      }
      context("when input on all field: username, company code, password") {
        it("should enable login button") {
          let username = "dummy-username"
          let password = "dummy-password"
          
          sut = LoginViewModel(usecase: successAuthUseCaseMock)
          
          let loginButonEnabled = scheduler.createObserver(Bool.self)
          
          scheduler.createColdObservable([.next(0, username)])
            .bind(to: sut.input.username)
            .disposed(by: disposedBag)
          scheduler.createColdObservable([.next(0, password)])
            .bind(to: sut.input.password)
            .disposed(by: disposedBag)
          sut.output.loginResult.enabled
            .bind(to: loginButonEnabled)
            .disposed(by: disposedBag)
          
          scheduler.start()
          
          expect(loginButonEnabled.events).toEventually(equal([
            .next(0, false),
            .next(0, true),
          ]))
        }
      }
      context("when input wrong") {
        it("should get output error message") {
          let username = "dummy-username"
          let password = "dummy-password"
          
          sut = LoginViewModel(usecase: errorAuthUseCaseMock)
          
          let loginError = scheduler.createObserver(ActionError.self)
          
          scheduler.createColdObservable([.next(0, username)])
            .bind(to: sut.input.username)
            .disposed(by: disposedBag)
          scheduler.createColdObservable([.next(0, password)])
            .bind(to: sut.input.password)
            .disposed(by: disposedBag)
          scheduler.createColdObservable([.next(1, ())])
            .bind(to: sut.input.loginAction)
            .disposed(by: disposedBag)
          
          sut.output.loginResult.errors
            .bind(to: loginError)
            .disposed(by: disposedBag)
          
          scheduler.start()
          
          expect(loginError.events).toEventually(equal([
            .next(1, ActionError.underlyingError(AuthUseCaseError.loginError)),
          ]))
        }
      }
      context("when input valid") {
        it("should get valid user information") {
          let username = "dummy-username"
          let password = "dummy-password"
          
          sut = LoginViewModel(usecase: successAuthUseCaseMock)
          
          let credential = scheduler.createObserver(Credential.self)
          
          scheduler.createColdObservable([.next(0, username)])
            .bind(to: sut.input.username)
            .disposed(by: disposedBag)
          scheduler.createColdObservable([.next(0, password)])
            .bind(to: sut.input.password)
            .disposed(by: disposedBag)
          scheduler.createColdObservable([.next(1, ())])
            .bind(to: sut.input.loginAction)
            .disposed(by: disposedBag)
          
          sut.output.loginResult.elements
            .bind(to: credential)
            .disposed(by: disposedBag)
          
          scheduler.start()
          
          expect(credential.events).toEventually(equal([
            .next(1, Credential(success: true, expiresAt: nil, requestToken: nil)),
          ]))
        }
      }
    }
  }
}

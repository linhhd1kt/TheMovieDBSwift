//
//  AuthRepositorySpec.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Action
import Data
import Nimble
import Quick
import RxSwift
import RxTest
import Services

@testable import SwiftBase

class AuthRepositorySpec: QuickSpec {
  override func spec() {
    var sut: AuthRepositoryType!
    var scheduler: TestScheduler!
    var disposedBag: DisposeBag!
    var failedNetworkMock: FailedNetworkMock!
    var successNetworkMock: SuccessNetworkMock!

    describe("Test Login view model") {
      beforeEach {
        disposedBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
        failedNetworkMock = FailedNetworkMock()
        successNetworkMock = SuccessNetworkMock()
      }
      context("when fetch with invalid input") {
        it("should executing and return error") {
          let username = "dummy-username"
          let password = "dummy-password"
          let token = "dummy-token"
          let request = CredentialRequest(username: username, password: password, requestToken: token)

          sut = AuthRepository(network: failedNetworkMock)

          let fetchError = scheduler.createObserver(ActionError.self)
          let fetchExecuting = scheduler.createObserver(Bool.self)

          sut.login.errors
            .bind(to: fetchError)
            .disposed(by: disposedBag)

          scheduler.createColdObservable([.next(0, request)])
            .bind(to: sut.login.inputs)
            .disposed(by: disposedBag)
          sut.login.executing
            .bind(to: fetchExecuting)
            .disposed(by: disposedBag)

          scheduler.start()

          expect(fetchError.events).toEventually(equal([
            .next(0, ActionError.underlyingError(NetworkError.client(code: 1, message: "dummy"))),
          ]))
          expect(fetchExecuting.events).toEventually(equal([
            .next(0, false),
            .next(0, true),
            .next(0, false),
          ]))
        }
      }
      context("when get error response from server") {
        it("should return error") {
          let username = "dummy-username"
          let token = "dummy-token"
          let password = "dummy-password"
          let request = CredentialRequest(username: username,
                                          password: password,
                                          requestToken: token)

          sut = AuthRepository(network: successNetworkMock)

          let fetchResult = scheduler.createObserver(CredentialResponse.self)
          let fetchExecuting = scheduler.createObserver(Bool.self)

          sut.login.elements
            .bind(to: fetchResult)
            .disposed(by: disposedBag)

          scheduler.createColdObservable([.next(0, request)])
            .bind(to: sut.login.inputs)
            .disposed(by: disposedBag)
          sut.login.executing
            .bind(to: fetchExecuting)
            .disposed(by: disposedBag)

          scheduler.start()

          expect(fetchResult.events).toEventually(equal([
            .next(0, CredentialResponse(success: true, expiresAt: nil, requestToken: nil))
          ]))
          expect(fetchExecuting.events).toEventually(equal([
            .next(0, false),
            .next(0, true),
            .next(0, false),
          ]))
        }
      }
    }
  }
}

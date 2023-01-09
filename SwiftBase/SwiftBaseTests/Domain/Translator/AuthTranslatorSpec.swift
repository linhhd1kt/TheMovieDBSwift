//
//  AuthTranslatorSpec.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Action
import Data
import Domain
import Nimble
import Quick
import RxSwift
import RxTest
import Services

@testable import SwiftBase

class AuthTranslatorSpec: QuickSpec {
  override func spec() {
    var sut: AuthTranslatorType!
    
    describe("Test authenticate translator") {
      beforeEach {
        sut = AuthTranslator()
      }

      context("test convert model to request") {
        it("should convert to valid request") {
          let username = "dummy-username"
          let password = "dummy-password"          

          let request = sut.toRequest(username: username, password: password)

          expect(request.username).to(equal(username))
          expect(request.password).to(equal(password))
        }
      }

      context("test convert response to model") {
        it("should convert reponse to valid model") {
          sut = AuthTranslator()

          let model = sut.toModel(response: CredentialResponse(success: true,
                                                               expiresAt: nil,
                                                               requestToken: nil))
          expect(model.success).to(equal(true))
          expect(model.expiresAt).to(beNil())
          expect(model.requestToken).to(beNil())
        }
      }
    }
  }
}

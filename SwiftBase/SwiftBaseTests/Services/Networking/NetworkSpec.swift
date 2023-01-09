//
//  NetworkSpec.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Action
import Data
import Domain
import Moya
import Nimble
import Quick
import RxSwift
import RxTest
import Services
@testable import SwiftBase

class NetworkSpec: QuickSpec {
  override func spec() {
    var sut: Networking!
    var scheduler: TestScheduler!
    var disposedBag: DisposeBag!
    var parser: ResponseParserType!

    describe("Test Network service") {
      beforeEach {
        disposedBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
        parser = ResponseParser()
      }
      context("when server return invalid format data") {
        it("should return invalid response error") {
          let mockProvider = MoyaProvider<APIMock>(stubClosure: MoyaProvider.immediatelyStub)
          let environtment = TestEnvironment()
          sut = Network(endPoint: environtment.baseUrl, provider: mockProvider, apiKey: environtment.apiKey)

          let requestError = scheduler.createObserver(DummyResponse.self)
          let api = APIMock(target: .invalidResponse)

          scheduler.createColdObservable([.next(0, api)])
            .flatMapLatest { api in
              sut.request(target: api)
            }
            .bind(to: requestError)
            .disposed(by: disposedBag)

          scheduler.start()

          expect(requestError.events).toEventually(equal([
            .error(0, NetworkError.invalidReponse(code: 200)),
          ]))
        }
      }
      context("when server return empty data") {
        it("should return decode response error") {
          let mockProvider = MoyaProvider<APIMock>(stubClosure: MoyaProvider.immediatelyStub)
          let environtment = TestEnvironment()
          sut = Network(endPoint: environtment.baseUrl, provider: mockProvider, apiKey: environtment.apiKey)

          let requestError = scheduler.createObserver(DummyResponse.self)
          let api = APIMock(target: .emptyResponse)

          scheduler.createColdObservable([.next(0, api)])
            .flatMapLatest { api in
              sut.request(target: api)
            }
            .bind(to: requestError)
            .disposed(by: disposedBag)

          scheduler.start()

          expect(requestError.events).toEventually(equal([
            .error(0, NetworkError.decode(code: 200)),
          ]))
        }
      }
      context("when server return invalid format data") {
        it("should return response error") {
          let mockProvider = MoyaProvider<APIMock>(stubClosure: MoyaProvider.immediatelyStub)
          let environtment = TestEnvironment()
          sut = Network(endPoint: environtment.baseUrl, provider: mockProvider, apiKey: environtment.apiKey)

          let requestError = scheduler.createObserver(DummyResponse.self)
          let api = APIMock(target: .successResponse)
          scheduler.createColdObservable([.next(0, api)])
            .flatMapLatest { api in
              sut.request(target: api)
            }
            .bind(to: requestError)
            .disposed(by: disposedBag)

          scheduler.start()

          expect(requestError.events).toEventually(equal([
            .next(0, DummyResponse(id: 123)),
          ]))
        }
      }
      context("when server return valid format data") {
        it("should return valid response") {
          let mockProvider = MoyaProvider<APIMock>(stubClosure: MoyaProvider.immediatelyStub)
          let data = DummyResponse.validData
          guard let dummyResponse = try? parser.parseJson(data: data,
                                                          statusCode: 200,
                                                          ofType: DummyResponse.self).get()
          else {
            fatalError("Login response should has value")
          }

          let environtment = TestEnvironment()
          sut = Network(endPoint: environtment.baseUrl, provider: mockProvider, apiKey: environtment.apiKey)

          let requestError = scheduler.createObserver(DummyResponse.self)
          let api = APIMock(target: .successResponse)
          scheduler.createColdObservable([.next(0, api)])
            .flatMapLatest { api in
              sut.request(target: api)
            }
            .bind(to: requestError)
            .disposed(by: disposedBag)

          scheduler.start()

          expect(requestError.events).toEventually(equal([
            .next(0, dummyResponse),
          ]))
        }
      }
      context("when server return failure response with valid format") {
        it("should return network failure response") {
          let mockProvider = MoyaProvider<APIMock>(stubClosure: MoyaProvider.immediatelyStub,
                                                   plugins: [ApiLogPlugin(logger: Logger())])
          let environtment = TestEnvironment()
          sut = Network(endPoint: environtment.baseUrl, provider: mockProvider, apiKey: environtment.apiKey)
          let responseResult = scheduler.createObserver(DummyResponse.self)
          let api = APIMock(target: .failureResponse)
          scheduler.createColdObservable([.next(0, api)])
            .flatMapLatest { api in
              sut.request(target: api)
            }
            .bind(to: responseResult)
            .disposed(by: disposedBag)

          scheduler.start()

          expect(responseResult.events).toEventually(equal([
            .error(0, NetworkError.client(code: 500, message: "ページがありません")),
          ]))
        }
      }
      context("when server return valid data") {
        it("should return valid object") {
          let mockProvider = MoyaProvider<APIMock>(stubClosure: MoyaProvider.immediatelyStub,
                                                   plugins: [ApiLogPlugin(logger: Logger())])
          let environtment = TestEnvironment()
          sut = Network(endPoint: environtment.baseUrl, provider: mockProvider, apiKey: environtment.apiKey)
          let responseResult = scheduler.createObserver(DummyResponse.self)
          let api = APIMock(target: .successResponse)
          scheduler.createColdObservable([.next(0, api)])
            .flatMapLatest { api in
              sut.request(target: api)
            }
            .bind(to: responseResult)
            .disposed(by: disposedBag)

          scheduler.start()

          expect(responseResult.events).toEventually(equal([
            .next(0, DummyResponse(id: 123)),
          ]))
        }
      }
    }
  }
}

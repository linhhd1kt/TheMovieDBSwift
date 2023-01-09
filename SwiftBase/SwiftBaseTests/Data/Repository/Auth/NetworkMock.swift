//
//  NetworkMock.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Moya
import RxSwift
import Services
import Data

class SuccessNetworkMock: Networking {
  var apiKey: String = TestEnvironment().apiKey
  var endPoint: URL = .init(string: "https://www.kodeco.com/7408-testing-your-rxswift-code")!
  
  func request<T>(target _: TargetType) -> Observable<T> where T: Decodable, T: Encodable {
    if let response = CredentialResponse(success: true, expiresAt: nil, requestToken: nil) as? T {
      return Observable.just(response)
    } else {
      return Observable<T>.empty()
    }
  }

  func setLogger(_: CanLogDebug) {}
}

class FailedNetworkMock: Networking {
  var apiKey: String = TestEnvironment().apiKey
  var endPoint: URL = .init(string: "https://www.kodeco.com/7408-testing-your-rxswift-code")!
  
  func request<T>(target _: TargetType) -> Observable<T> where T: Decodable, T: Encodable {
    return .error(NetworkError.client(code: 1, message: "dummy"))
  }

  func setLogger(_: CanLogDebug) {}
}

//
//  PaceBoxing.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import RxSwift
import Moya
import Alamofire

public protocol ApiRequestType {
  func toTarget(baseUrl: URL, apiKey: String) -> TargetType
}

public protocol Networking {
  var endPoint: URL { get }
  var apiKey: String { get }
  func request<T: Codable>(target: TargetType) -> Observable<T>
}

public class Network<Provider: MoyaProviderType>: Networking {
  private var provider: Provider
  private let parser: ResponseParserType
  public let endPoint: URL
  public let apiKey: String
  
  public init(parser: ResponseParserType = ResponseParser(),
              endPoint: URL,
              provider: Provider,
              apiKey: String) {
    self.parser = parser
    self.endPoint = endPoint
    self.provider = provider
    self.apiKey = apiKey
  }
  
  public func request<T: Codable>(target: TargetType) -> Observable<T> {
    guard let target = target as? Provider.Target else {
      fatalError("\(String(describing: target)) not a target type: \(Provider.Target.self)")
    }
    return .create { observer in
      self.provider.request(target, callbackQueue: nil, progress: nil) { [weak self] result in
        guard let self = self else {
          observer.onCompleted()
          return
        }
        switch result {
        case let .success(response):
          let parsedResult = self.parser.parseJson(data: response.data,
                                                   statusCode: response.statusCode,
                                                   ofType: T.self)
          switch parsedResult {
          case let .success(object):
            if let object = object {
              observer.onNext(object)
              observer.onCompleted()
            } else {
              observer.onError(NetworkError.system)
            }
          case let .failure(error):
            observer.onError(error)
          }
        case let .failure(error):
          if let alamofireError = error.errorUserInfo["NSUnderlyingError"] as? Alamofire.AFError,
             let underlyingError = alamofireError.underlyingError as? NSError {
            if underlyingError.domain == NSURLErrorDomain {
              if [NSURLErrorNotConnectedToInternet, NSURLErrorTimedOut, NSURLErrorNetworkConnectionLost]
                .contains(underlyingError.code) {
                observer.onError(NetworkError.connection(message: underlyingError.localizedDescription))
                return
              }
            }
          }
          observer.onError(NetworkError.invalidReponse(code: error.errorCode))
        }
      }
      return Disposables.create()
    }
  }
}

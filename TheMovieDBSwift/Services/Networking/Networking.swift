//
//  Networking.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 29/08/2022.
//

import Foundation
import RxSwift
import Moya
import RxMoya

protocol Networking {
    func request<T: Decodable>(target: TargetType) -> Observable<T>
}

class Network: Networking {
    let provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])
        
    var responseParser: ResponseParsable {
        guard let parser = ServiceFacade.getService(ResponseParsable.self) else {
            fatalError("Response Parser should be implementation!")
        }
        return parser
    }
    
    func request<T>(target: TargetType) -> Observable<T> where T : Decodable {
        guard let target = target as? API else {
            return .error(CommonError.missingImplement(type: "\(API.self)"))
        }
        return .create { observer in
            self.provider.request(target) { [unowned self] result in
                switch result {
                case .success(let response):
                    if let error = self.responseParser.parseError(response: response) {
                        observer.onError(error)
                    } else {
                        do {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let object = try decoder.decode(T.self, from: response.data)
                            observer.onNext(object)
                        } catch {
                            observer.onError(CommonError.decode(description: error.localizedDescription))
                        }
                    }
                case .failure(let error):
                    observer.onError(NetworkError.invalidReponse(message: error.localizedDescription))
                }
            }
            return Disposables.create()
        }
    }
}

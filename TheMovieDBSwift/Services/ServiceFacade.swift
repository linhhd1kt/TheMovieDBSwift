//
//  ServiceFacade.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 26/08/2022.
//

import Swinject
import UIKit
import Alamofire
import RealmSwift
import Foundation
import Combine

extension Container {
    static var `default` = Container()
}

class ServiceFacade {
    private static let logger: Logable = Logger()
    private static let userPreferencesStorage: UserPreferencesStorable = UserPreferencesStorage()
    private static let appCoordinator: CoordinatorType = AppCoordinator()
    private static let network: Networking = Network()
    private static let persistantStorage: PersistantStorable = RealmPersistantStorage()
    private static let responseParser: ResponseParsable = ResponseParser()
    
    static func registerDefaultService() {
        initializeService()
    }

    static func getService<T>(_ type: T.Type) -> T? {
        return Container.default.resolve(type)
    }

    private static func initializeService() {
        Container.default.register(Logable.self) { _ in
            ServiceFacade.logger
        }
        Container.default.register(UserPreferencesStorable.self) { _ in
            ServiceFacade.userPreferencesStorage
        }
        Container.default.register(CoordinatorType.self) { _ in
            ServiceFacade.appCoordinator
        }
        Container.default.register(PersistantStorable.self) { _ in
            ServiceFacade.persistantStorage
        }
        Container.default.register(ResponseParsable.self) { _ in
            ServiceFacade.responseParser
        }
        Container.default.register(Networking.self) { _ in
            ServiceFacade.network
        }
    }

    static func shutDownAllService() {
    }
}

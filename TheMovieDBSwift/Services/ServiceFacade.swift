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
    
    private static let coordinator: Coordinator = MainCoordinator(navigationController: UINavigationController())

    private static let userPreferencesStorage: UserPreferencesStorable = UserPreferencesStorage()
    private static let network: Networking = Network()
    private static let persistantStorage: PersistantStorable = RealmPersistantStorage()
    private static let responseParser: ResponseParsable = ResponseParser()

    static func registerDefaultService(from windown: UIWindow?) {
        initializeService(from: windown)
    }

    static func getService<T>(_ type: T.Type) -> T? {
        return Container.default.resolve(type)
    }

    private static func initializeService(from window: UIWindow?) {
        Container.default.register(UserPreferencesStorable.self) { _ in
            ServiceFacade.userPreferencesStorage
        }
        Container.default.register(Coordinator.self) { _ in
            ServiceFacade.coordinator
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



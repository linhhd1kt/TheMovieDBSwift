//
//  ServiceFacade.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Design
import Domain
import Moya
import Services
import Swinject
import Data

extension Container {
  static var `default` = Container()
}

enum ServiceFacade {
  private static let design: Designable = DefautDesign()
  private static let logger: Logable = Logger()
  private static let appCoordinator: CoordinatorType = AppCoordinator()
  private static let appConfig: AppConfigType = AppConfig()

  private static let network: Networking = Network(endPoint: Environment.shared.baseUrl,
                                                   provider: MoyaProvider<API>(plugins: [NetworkLogPlugin(logger: Logger())]),
                                                   apiKey: Environment.shared.apiKey)
  private static let responseParser: ResponseParserType = ResponseParser()
  private static let imageLoader: ImageLoaderType = ImageLoader(baseImageURL: Environment.shared.baseImageUrl)

  static func registerDefaultService() {
    initializeService()
  }

  static func getService<T>(_ type: T.Type) -> T? {
    return Container.default.resolve(type)
  }

  private static func initializeService() {
    Container.default.register(Designable.self) { _ in
      ServiceFacade.design
    }
    Container.default.register(Logable.self) { _ in
      ServiceFacade.logger
    }
    Container.default.register(CoordinatorType.self) { _ in
      ServiceFacade.appCoordinator
    }
    Container.default.register(ResponseParserType.self) { _ in
      ServiceFacade.responseParser
    }
    Container.default.register(Networking.self) { _ in
      ServiceFacade.network
    }
    Container.default.register(AppConfigType.self) { _ in
      ServiceFacade.appConfig
    }
    Container.default.register(ImageLoaderType.self) { _ in
      ServiceFacade.imageLoader
    }
    
    appConfig.configureAppearance()
    appConfig.configureLanguage()
  }

  static func shutDownAllService() {
    Container.default.removeAll()
  }
}

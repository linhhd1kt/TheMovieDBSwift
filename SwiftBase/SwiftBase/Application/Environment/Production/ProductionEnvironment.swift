//
//  ProductionEndPoint.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Domain

public struct ProductionEnvironment: EnvironmentType {
  public var baseUrl: URL = .init(string: "https://api.themoviedb.org")!
  public var baseImageUrl: URL = .init(string: "http://image.tmdb.org")!
  public var privacyUrl: URL = .init(string: "https://www.themoviedb.org/privacy-policy")!
  public var contactUrl: URL = .init(string: "https://www.themoviedb.org/about/staying-in-touch")!
  public var termsUrl: URL = .init(string: "https://www.themoviedb.org/terms-of-use")!
  public var apiKey: String = "6c4ace606c2f60c95dc9ae547be5e4d6"
}

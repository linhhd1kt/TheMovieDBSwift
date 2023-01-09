//
//  StaffAPI.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Moya

public enum APITarget {
  case createRequestToken
  case createSessionWithLogin(parameters: [String: Any])
  case popularMovie(page: Int)
  case movie(movieId: String)
  case search(query: String)
  case discoverMovie(page: Int, monetization: MonetizationType, releaseTypes: Set<ReleaseType>)
  case discoverTv(page: Int, monetization: MonetizationType, releaseTypes: Set<ReleaseType>)
  case trending(page: Int, mediaType: MediaType, timeWindow: TimeWindow)
  case latestTrailerOnTv
  case latestTrailerOnThreaters
}

public class API: TargetType {
  public var baseURL: URL

  private let target: APITarget

  private let apiKey: String

  public var path: String {
    switch target {
    case .createRequestToken:
      return "3/authentication/token/new"
    case .createSessionWithLogin:
      return "3/authentication/token/validate_with_login"
    case .popularMovie:
      return "3/movie/popular"
    case let .movie(movieId):
      return "3/movie/\(movieId)"
    case .search:
      return "3/search/movie"
    case .discoverMovie:
      return "3/discover/movie"
    case .discoverTv:
      return "3/discover/tv"
    // swiftlint:disable pattern_matching_keywords
    case .trending(page: _, mediaType: let mediaType, timeWindow: let timeWindow):
      return "3/trending/\(mediaType)/\(timeWindow)"
    case .latestTrailerOnTv:
      return "3/disvoer/tv"
    case .latestTrailerOnThreaters:
      return "3/discover/movie"
    }
  }

  public var method: Moya.Method {
    switch target {
    case .createSessionWithLogin:
      return .post
    default:
      return .get
    }
  }

  public var sampleData: Data {
    return Data()
  }

  public var task: Task {
    switch target {
    case .createRequestToken:
      return .requestParameters(parameters: ["api_key": apiKey],
                                encoding: URLEncoding.queryString)
    case var .createSessionWithLogin(parameters):
      let bodyParameter: [String: Any] = ["api_key": apiKey]
      return .requestCompositeParameters(bodyParameters: parameters,
                                         bodyEncoding: URLEncoding.httpBody,
                                         urlParameters: bodyParameter)
    case let .popularMovie(page: page):
      return .requestParameters(parameters: ["api_key": apiKey,
                                             "page": page],
                                encoding: URLEncoding.queryString)
    case .movie:
      return .requestParameters(parameters: ["api_key": apiKey],
                                encoding: URLEncoding.httpBody)
    case let .search(query):
      return .requestParameters(parameters: ["query": query, "api_key": apiKey], encoding: URLEncoding.queryString)
    case let .discoverMovie(page: page, monetization: monetization, releaseTypes: releaseTypes):
      var parameters: [String: Any] = [:]
      parameters["api_key"] = apiKey
      parameters["page"] = page
      parameters["with_watch_monetization_types"] = monetization.filterParameter
      if !releaseTypes.isEmpty {
        parameters["with_release_type"] = releaseTypes.map { "\($0.rawValue)" }.joined(separator: "|")
      }
      return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
    case let .discoverTv(page: page,
                         monetization: monetization,
                         releaseTypes: releaseTypes):
      var parameters: [String: Any] = [:]
      parameters["api_key"] = apiKey
      parameters["page"] = page
      parameters["with_watch_monetization_types"] = monetization.filterParameter
      return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
    case .trending:
      var parameters: [String: Any] = [:]
      parameters["api_key"] = apiKey
      return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
    case .latestTrailerOnTv:
      var parameters: [String: Any] = [:]
      parameters["api_key"] = apiKey
      return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
    case .latestTrailerOnThreaters:
      var parameters: [String: Any] = [:]
      parameters["api_key"] = apiKey
      return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
    }
  }

  public var headers: [String: String]? {
    return nil
  }

  public init(baseURL: URL, target: APITarget, apiKey: String) {
    self.baseURL = baseURL
    self.target = target
    self.apiKey = apiKey
  }
}

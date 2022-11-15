//
//  API.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 29/08/2022.
//

import Foundation
import Moya

protocol ApiRequestable {
    func toTarget() -> TargetType
}

enum API {
    case createRequestToken
    case createSessionWithLogin(parameters: [String: Any])
    case popularMovie(page: Int)
    case movie(movieId: String)
    case search(query: String)
    case discoverMovie(page: Int, monetization: MonetizationType, releaseTypes: Set<ReleaseType>)
    case discoverTV(page: Int, monetization: MonetizationType)
}

extension API: TargetType {
    var baseURL: URL {
        guard let url = URL(string: AppConfiguration().apiBaseURL) else {
            fatalError("Base URL invalid!")
        }
        return url.appendingPathComponent("3")
    }
    
    var path: String {
        switch self {
        case .createRequestToken:
            return "/authentication/token/new"
        case .createSessionWithLogin:
            return "/authentication/token/validate_with_login"
        case .popularMovie:
            return "movie/popular"
        case .movie(let movieId):
            return "movie/\(movieId)"
        case .search:
            return "search/movie"
        case .discoverMovie:
            return "discover/movie"
        case .discoverTV:
            return "discover/tv"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createSessionWithLogin:
            return .post
        default: return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .createRequestToken:
            return .requestParameters(parameters: ["api_key": AppConfiguration().apiKey],
                                      encoding: URLEncoding.queryString)
        case .createSessionWithLogin(let parameters):
            let urlParameter: [String: Any] = ["api_key": AppConfiguration().apiKey]
            return .requestCompositeParameters(bodyParameters: parameters,
                                               bodyEncoding: URLEncoding.httpBody,
                                               urlParameters: urlParameter)
        case .popularMovie(page: let page):
            return .requestParameters(parameters: ["api_key": AppConfiguration().apiKey,
                                                   "page": page],
                                      encoding: URLEncoding.queryString)
        case .movie:
            return .requestParameters(parameters: ["api_key": AppConfiguration().apiKey],
                                      encoding: URLEncoding.httpBody)
        case .search(let query):
            return .requestParameters(parameters: ["query": query, "api_key": AppConfiguration().apiKey], encoding: URLEncoding.queryString)
        case .discoverMovie(page: let page, monetization: let monetization, releaseTypes: let releaseTypes):
            var parameters: [String: Any] = [:]
            parameters["api_key"] = AppConfiguration().apiKey
            parameters["page"] = page
            parameters["with_watch_monetization_types"] = monetization.filterParameter
            if !releaseTypes.isEmpty {
                parameters["with_release_type"] = releaseTypes.map { "\($0.rawValue)" }.joined(separator: "|")
            }
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .discoverTV(page: let page, monetization: let monetization):
            var parameters: [String: Any] = [:]
            parameters["api_key"] = AppConfiguration().apiKey
            parameters["page"] = page
            parameters["with_watch_monetization_types"] = monetization.filterParameter
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}

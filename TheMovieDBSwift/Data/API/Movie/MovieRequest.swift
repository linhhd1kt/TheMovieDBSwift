//
//  MovieRequest.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 20/10/2022.
//

import Foundation
import Moya

struct PopularMovieRequest {
    let page: Int
    let monetization: MonetizationType
    let releaseTypes: Set<ReleaseType>
}

extension PopularMovieRequest: ApiRequestable {
    func toTarget() -> TargetType {
        return API.discoverMovie(page: page, monetization: monetization, releaseTypes: releaseTypes)
    }
}

struct FreeWatchMovieRequest {
    let page: Int
}

extension FreeWatchMovieRequest: ApiRequestable {
    func toTarget() -> TargetType {
        return API.discoverMovie(page: page, monetization: .free, releaseTypes: [])
    }
}

struct FreeWatchTVRequest {
    let page: Int
}

extension FreeWatchTVRequest: ApiRequestable {
    func toTarget() -> TargetType {
        return API.discoverTV(page: page, monetization: .free)
    }
}

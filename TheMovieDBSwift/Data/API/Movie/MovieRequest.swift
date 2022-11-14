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
}

extension PopularMovieRequest: ApiRequestable {
    func toTarget() -> TargetType {
        return API.popularMovie(page: page)
    }
}

struct DiscoverMovieRequest {
    let page: Int
    let monetization: MonetizationType
}

extension DiscoverMovieRequest: ApiRequestable {
    func toTarget() -> TargetType {
        return API.discover(page: page, monetization: monetization)
    }
}

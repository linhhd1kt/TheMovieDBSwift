//
//  Page.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 20/10/2022.
//

import Foundation

protocol Paginated {
    associatedtype Element
    
    var page: Int { get set }
    var results: [Element] { get set }
    var totalResults: Int { get set }
    var totalPages: Int { get set }
}

struct MoviePage: Paginated {
    typealias Element = Movie
    
    var page: Int
    var results: [Element]
    var totalResults: Int
    var totalPages: Int
    
    static var empty: MoviePage {
        return MoviePage(page: 0, results: [], totalResults: 0, totalPages: 0)
    }
}

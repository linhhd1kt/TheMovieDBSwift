//
//  Page.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 20/10/2022.
//

import Foundation

struct Page<Element> {
    var page: Int
    var results: [Element]
    var totalResults: Int
    var totalPages: Int
    
    static var empty: Page<Element> {
        return Page(page: 0, results: [], totalResults: 0, totalPages: 0)
    }
}

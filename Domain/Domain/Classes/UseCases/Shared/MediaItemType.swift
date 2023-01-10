//
//  MediaItemType.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Data

public protocol MediaItemType {
  var id: Int { get }
  var posterPath: String { get }
  var overview: String { get }
  var date: String { get }
  var name: String { get }
  var backdropPath: String { get }
  var popularity: Double { get }
  var voteCount: Int { get }
  var voteAverage: Double { get }
}

public struct MediaPage: Paginated {
  public typealias Element = MediaItemType

  public var page: Int
  public var results: [Element]
  public var totalResults: Int
  public var totalPages: Int

  public static var empty: MediaPage {
    return MediaPage(page: 0, results: [], totalResults: 0, totalPages: 0)
  }

  public init() {
    self.init(page: 0, results: [], totalResults: 0, totalPages: 0)
  }

  public init(page: Int, results: [Element], totalResults: Int, totalPages: Int) {
    self.page = page
    self.results = results
    self.totalResults = totalResults
    self.totalPages = totalPages
  }
}

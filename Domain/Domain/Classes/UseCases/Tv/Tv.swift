//
//  Movie.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Data

public struct Tv {
  public let id: Int
  public let posterPath: String
  public let originCountry: [String]
  public let overview: String
  public let firstAirDate: String
  public let genreIds: [Int]
  public let originalName: String
  public let originalLanguage: String
  public let name: String
  public let backdropPath: String
  public let popularity: Double
  public let voteCount: Int
  public let video: Bool
  public let voteAverage: Double

  public init(id: Int,
              posterPath: String,
              originCountry: [String],
              overview: String,
              firstAirDate: String,
              genreIds: [Int],
              originalName: String,
              originalLanguage: String,
              name: String,
              backdropPath: String,
              popularity: Double,
              voteCount: Int,
              video: Bool,
              voteAverage: Double) {
    self.id = id
    self.posterPath = posterPath
    self.originCountry = originCountry
    self.overview = overview
    self.firstAirDate = firstAirDate
    self.genreIds = genreIds
    self.originalName = originalName
    self.originalLanguage = originalLanguage
    self.name = name
    self.backdropPath = backdropPath
    self.popularity = popularity
    self.voteCount = voteCount
    self.video = video
    self.voteAverage = voteAverage
  }
}

public struct TvPage: Paginated {
  public typealias Element = Tv

  public var page: Int
  public var results: [Element]
  public var totalResults: Int
  public var totalPages: Int

  public static var empty: TvPage {
    return TvPage(page: 0, results: [], totalResults: 0, totalPages: 0)
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

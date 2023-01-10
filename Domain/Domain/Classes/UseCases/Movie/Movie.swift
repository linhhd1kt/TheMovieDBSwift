//
//  Movie.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Data

public struct Movie: MediaItemType {
  public let id: Int
  public let posterPath: String
  public let adult: Bool
  public let overview: String
  public let releaseDate: String
  public let genreIds: [Int]
  public let originalTitle: String
  public let originalLanguage: String
  public let title: String
  public let backdropPath: String
  public let popularity: Double
  public let voteCount: Int
  public let video: Bool
  public let voteAverage: Double
  
  public var date: String {
    return releaseDate
  }
  public var name: String {
    return title
  }

  public init(id: Int,
              posterPath: String,
              adult: Bool,
              overview: String,
              releaseDate: String,
              genreIds: [Int],
              originalTitle: String,
              originalLanguage: String,
              title: String,
              backdropPath: String,
              popularity: Double,
              voteCount: Int,
              video: Bool,
              voteAverage: Double) {
    self.id = id
    self.posterPath = posterPath
    self.adult = adult
    self.overview = overview
    self.releaseDate = releaseDate
    self.genreIds = genreIds
    self.originalTitle = originalTitle
    self.originalLanguage = originalLanguage
    self.title = title
    self.backdropPath = backdropPath
    self.popularity = popularity
    self.voteCount = voteCount
    self.video = video
    self.voteAverage = voteAverage
  }
}

public struct MoviePage: Paginated {
  public typealias Element = Movie

  public var page: Int
  public var results: [Element]
  public var totalResults: Int
  public var totalPages: Int

  public static var empty: MoviePage {
    return MoviePage(page: 0, results: [], totalResults: 0, totalPages: 0)
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

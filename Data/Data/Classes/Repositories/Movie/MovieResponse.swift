//
//  MovieResponse.swift
//  SwiftBase
//
//  Copyright © HaLinh Co., Ltd.
//

import Foundation

public struct MovieResponse: Codable {
  public struct Data: Codable {
    public let posterPath: String
    public let adult: Bool
    public let overview: String
    public let releaseDate: String
    public let genreIDS: [Int]
    public let id: Int
    public let originalTitle: String
    public let originalLanguage: String
    public let title: String
    public let backdropPath: String
    public let popularity: Double
    public let voteCount: Int
    public let video: Bool
    public let voteAverage: Double
    
    public enum CodingKeys: String, CodingKey {
      case posterPath = "poster_path"
      case adult, overview
      case releaseDate = "release_date"
      case genreIDS = "genre_ids"
      case id
      case originalTitle = "original_title"
      case originalLanguage = "original_language"
      case title
      case backdropPath = "backdrop_path"
      case popularity
      case voteCount = "vote_count"
      case video
      case voteAverage = "vote_average"
    }
    
    public init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
      posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
      adult = try container.decodeIfPresent(Bool.self, forKey: .adult) ?? false
      overview = try container.decodeIfPresent(String.self, forKey: .overview) ?? ""
      releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate) ?? "2000-01-01"
      genreIDS = try container.decodeIfPresent([Int].self, forKey: .genreIDS) ?? []
      originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle) ?? ""
      originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage) ?? "en"
      title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
      backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath) ?? ""
      popularity = try container.decodeIfPresent(Double.self, forKey: .popularity) ?? 0.0
      voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount) ?? 0
      video = try container.decodeIfPresent(Bool.self, forKey: .video) ?? false
      voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage) ?? 0.0
    }
  }
  
  public enum CodingKeys: String, CodingKey {
    case page = "page"
    case results = "results"
    case totalResults = "total_results"
    case totalPages = "total_pages"
  }
  
  public let page: Int
  public let results: [Data]
  public let totalResults: Int
  public let totalPages: Int
}

//
//  MovieResponse.swift
//  TheMovieDBSwift
//
//  Created by Ha Linh on 20/10/2022.
//

import Foundation

struct MoviesResponse: Codable {
    struct Data: Codable {
        let posterPath: String
        let adult: Bool
        let overview: String
        let releaseDate: String
        let genreIDS: [Int]
        let id: Int
        let originalTitle: String
        let originalLanguage: String
        let title: String
        let backdropPath: String
        let popularity: Double
        let voteCount: Int
        let video: Bool
        let voteAverage: Double
        
        enum CodingKeys: String, CodingKey {
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
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
            posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
            adult = try container.decodeIfPresent(Bool.self, forKey: .adult) ?? false
            overview = try container.decodeIfPresent(String.self, forKey: .overview) ?? ""
            releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate) ?? "2000-01-01"
            genreIDS = try container.decodeIfPresent([Int].self, forKey: .genreIDS) ?? []
            originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle) ?? ""
            originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage) ?? ""
            title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
            backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath) ?? ""
            popularity = try container.decodeIfPresent(Double.self, forKey: .popularity) ?? 0.0
            voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount) ?? 0
            video = try container.decodeIfPresent(Bool.self, forKey: .video) ?? false
            voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage) ?? 0.0
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }

    let page: Int
    let results: [Data]
    let totalResults: Int
    let totalPages: Int
}

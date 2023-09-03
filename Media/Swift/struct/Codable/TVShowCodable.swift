// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let tVShow = try? JSONDecoder().decode(TVShow.self, from: jsonData)

import Foundation

// MARK: - TVShow
struct TVShow: Codable {
    let page: Int
    let results: [TVResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct TVResult: Codable {
    let adult: Bool
    let backdropPath, posterPath: String?
    let id: Int
    let name: String
    let originalLanguage: String
    let originalName, overview: String
    let mediaType: TVMediaType
    let genreIDS: [Int]
    let popularity: Double
    let firstAirDate: String
    let voteAverage: Double
    let voteCount: Int
    let originCountry: [String]

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, name
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case originCountry = "origin_country"
    }
}

enum TVMediaType: String, Codable {
    case tv = "tv"
}

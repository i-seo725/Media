// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movie = try? JSONDecoder().decode(Movie.self, from: jsonData)

import Foundation

// MARK: - Movie
struct Movie: Codable {
    let totalPages, totalResults, page: Int
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case page, results
    }
}

// MARK: - Result
struct Result: Codable {
    let voteCount, id: Int
    let adult: Bool
    let backdropPath: String
    let genreID: [Int]
    let title, posterPath, overview, releaseDate: String
    let popularity: Double
    let mediaType: MediaType
    let originalTitle: String
    let video: Bool
    let originalLanguage: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case id, adult
        case backdropPath = "backdrop_path"
        case genreID = "genre_ids"
        case title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case popularity
        case mediaType = "media_type"
        case originalTitle = "original_title"
        case video
        case originalLanguage = "original_language"
        case voteAverage = "vote_average"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
}

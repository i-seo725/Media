// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let credit = try? JSONDecoder().decode(Credit.self, from: jsonData)

import Foundation

// MARK: - Credit
struct Credit: Codable {
    let crew: [Cast]
    let id: Int
    let cast: [Cast]
}

// MARK: - Cast
struct Cast: Codable {
    let castID: Int?
    let adult: Bool
    let name: String
    let order: Int?
    let originalName, knownForDepartment: String
    let gender: Int
    let popularity: Double
    let id: Int
    let character: String?
    let profilePath: String?
    let creditID: String
    let department, job: String?

    enum CodingKeys: String, CodingKey {
        case castID = "cast_id"
        case adult, name, order
        case originalName = "original_name"
        case knownForDepartment = "known_for_department"
        case gender, popularity, id, character
        case profilePath = "profile_path"
        case creditID = "credit_id"
        case department, job
    }
}

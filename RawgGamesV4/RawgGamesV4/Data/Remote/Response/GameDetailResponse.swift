//
//  DetailResponse.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 07/02/24.
//

/// Response api data for game detail.
struct GameDetailResponse: Codable {
    let id: Int
    let name: String
    let released: String
    let description: String
    let metacritic: Int
    let rating: Double
    let playtime: Int
    let backgroundImage: String
    let backgroundImageAdditional: String

    enum CodingKeys: String, CodingKey {
        case id, name, released, description, metacritic, rating, playtime
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
    }
}

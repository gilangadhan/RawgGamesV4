//
//  ListResponse.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 07/02/24.
//

/// Response api data for list games.
struct GameListResponse: Codable {
    let results: [ListResultResponse]
}

struct ListResultResponse: Codable {
    let id: Int
    let name: String
    let released: String
    let rating: Double
    let backgroundImage: String

    enum CodingKeys: String, CodingKey {
        case id, name, released, rating
        case backgroundImage = "background_image"
    }
}

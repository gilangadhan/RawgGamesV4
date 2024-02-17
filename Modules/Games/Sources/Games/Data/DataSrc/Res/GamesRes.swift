//
//  File.swift
//  
//
//  Created by Dhimas Dewanto on 10/02/24.
//

/// Response api data for list games.
public struct GamesRes: Codable {
    public let results: [ListResultResponse]
}

public struct ListResultResponse: Codable {
    public let id: Int
    public let name: String
    public let released: String
    public let rating: Double
    public let backgroundImage: String

    enum CodingKeys: String, CodingKey {
        case id, name, released, rating
        case backgroundImage = "background_image"
    }
}

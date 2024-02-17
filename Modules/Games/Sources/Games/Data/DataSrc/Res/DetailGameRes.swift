//
//  File.swift
//  
//
//  Created by Dhimas Dewanto on 10/02/24.
//

import Foundation

/// Response api data for game detail.
public struct DetailGameRes: Codable {
    public let id: Int
    public let name: String
    public let released: String
    public let description: String
    public let metacritic: Int
    public let rating: Double
    public let playtime: Int
    public let backgroundImage: String
    public let backgroundImageAdditional: String

    enum CodingKeys: String, CodingKey {
        case id, name, released, description, metacritic, rating, playtime
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
    }
}

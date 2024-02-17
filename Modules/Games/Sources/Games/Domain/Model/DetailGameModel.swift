//
//  File.swift
//  
//
//  Created by Dhimas Dewanto on 10/02/24.
//

import Foundation

/// Model for detail game.
public struct DetailGameModel: Codable {
    public let id: Int
    public let name: String
    public let released: Date?
    public let description: String
    public let metacritic: Int
    public let rating: Double
    public let playtime: Int
    public let bgImg: String
    public let moreBgImg: String

    public init(
        id: Int,
        name: String,
        released: Date?,
        description: String,
        metacritic: Int,
        rating: Double,
        playtime: Int,
        bgImg: String,
        moreBgImg: String
    ) {
        self.id = id
        self.name = name
        self.released = released
        self.description = description
        self.metacritic = metacritic
        self.rating = rating
        self.playtime = playtime
        self.bgImg = bgImg
        self.moreBgImg = moreBgImg
    }
}

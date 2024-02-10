//
//  GameModel.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 07/02/24.
//

import Foundation

/// Model for list games, favorite games, and list result of search games.
public struct GameModel {
    public let id: String
    public let title: String
    public let imgSrc: String
    public let released: Date?
    public let rating: Double

    public init(id: String, title: String, imgSrc: String, released: Date?, rating: Double) {
        self.id = id
        self.title = title
        self.imgSrc = imgSrc
        self.released = released
        self.rating = rating
    }
}

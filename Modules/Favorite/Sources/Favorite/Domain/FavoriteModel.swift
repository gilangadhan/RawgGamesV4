//
//  File.swift
//  
//
//  Created by TMLI IT Dev on 11/02/24.
//

import Foundation

/// Model for favorite games.
public struct FavoriteModel {
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

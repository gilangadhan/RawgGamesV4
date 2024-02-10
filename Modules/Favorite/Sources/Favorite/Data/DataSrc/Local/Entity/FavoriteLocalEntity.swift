//
//  File.swift
//  
//
//  Created by TMLI IT Dev on 11/02/24.
//

import CoreData
import Foundation

/// Need to use this because entity from Core Data, `FavoriteEntity` need
/// `context` to create entity, and `context` can't just be passed like normal parameter.
public struct FavoriteLocalEntity {
    public let id: String
    public let title: String
    public let imgSrc: String
    public let rating: Double
    public let released: Date?

    public init(id: String, title: String, imgSrc: String, rating: Double, released: Date?) {
        self.id = id
        self.title = title
        self.imgSrc = imgSrc
        self.rating = rating
        self.released = released
    }

    func setCoreData(context: NSManagedObjectContext) {
        let favorite = FavoriteEntity(context: context)
        favorite.id = id
        favorite.title = title
        favorite.imgSrc = imgSrc
        favorite.rating = rating
        favorite.released = released
    }
}

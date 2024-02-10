//
//  FavoriteDataSourceImpl.swift
//  RawgGamesV4
//
//  Created by Dhimas Dewanto on 08/02/24.
//

import Combine
import CoreData
import Games

/// Handle favorite from local storage.
class FavoriteDataSourceImpl: FavoriteDataSource {
    private let manager: CoreDataManager

    init(manager: CoreDataManager) {
        self.manager = manager
    }

    /// Get context for Core Data.
    private var context: NSManagedObjectContext {
        manager.container.viewContext
    }

    /// Get favorite games from local storage.
    func getFavorites() -> AnyPublisher<[FavoriteEntity], Error> {
        let favorite = FavoriteEntity.fetchRequest()
        /// Sort by title first.
        favorite.sortDescriptors = [
            NSSortDescriptor(key: "title", ascending: true)
        ]

        let coreDataPublisher = CoreDataPublisher(
            request: favorite,
            context: context
        ).eraseToAnyPublisher()
        return coreDataPublisher
    }

    func addFavorite(game: GameModel) throws {
        let favorite = FavoriteEntity(context: context)
        favorite.id = game.id
        favorite.title = game.title
        favorite.imgSrc = game.imgSrc
        favorite.rating = game.rating
        favorite.released = game.released
        try context.save()
    }

    func removeFavorite(id: String) throws {
        let fetchRequest = FavoriteEntity.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == \(id)")

        let result = try context.fetch(fetchRequest).first
        if let result = result {
            context.delete(result)

            /// Commit delete favorite.
            try context.save()
        }
    }
}

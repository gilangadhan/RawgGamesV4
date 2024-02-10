//
//  File.swift
//
//
//  Created by TMLI IT Dev on 11/02/24.
//

import Combine
import Core
import CoreData
import Foundation

public struct FavoriteLocalSrc: LocalSrc {

    public typealias Req = Any

    public typealias Res = FavoriteLocalEntity

    public typealias IdType = String

    private let manager: CoreDataManager

    public init(manager: CoreDataManager) {
        self.manager = manager
    }

    /// Get context for Core Data.
    private var context: NSManagedObjectContext {
        manager.container.viewContext
    }

    public func getList(_ request: Req?) -> AnyPublisher<[Res], Error> {
        let favorite = FavoriteEntity.fetchRequest()
        /// Sort by title first.
        favorite.sortDescriptors = [
            NSSortDescriptor(key: "title", ascending: true)
        ]

        let coreDataPublisher = CoreDataPublisher(
            request: favorite,
            context: context
        )
            .map({ listEntities in
                listEntities.map { entity in
                    FavoriteLocalEntity(
                        id: entity.id ?? "",
                        title: entity.title ?? "",
                        imgSrc: entity.imgSrc ?? "",
                        rating: entity.rating,
                        released: entity.released
                    )
                }
            })
            .eraseToAnyPublisher()
        return coreDataPublisher
    }

    public func get(id: IdType) -> AnyPublisher<Res?, Error> {
        let future = Future<Res?, Error> {
            let fetchRequest = FavoriteEntity.fetchRequest()
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            let entity = try context.fetch(fetchRequest).first
            if let entity = entity {
                return FavoriteLocalEntity(
                    id: entity.id ?? "",
                    title: entity.title ?? "",
                    imgSrc: entity.imgSrc ?? "",
                    rating: entity.rating,
                    released: entity.released
                )
            }
            return nil
        }
        return future.eraseToAnyPublisher()
    }

    public func add(entities: [Res]) -> AnyPublisher<Void, Error> {
        let future = Future<Void, Error> {
            for entity in entities {
                entity.setCoreData(context: context)
            }
            try context.save()
        }
        return future.eraseToAnyPublisher()
    }

    public func update(id: IdType, entity: Res) -> AnyPublisher<Void, Error> {
        let future = Future<Void, Error> {
            let fetchRequest = FavoriteEntity.fetchRequest()
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            let favorite = try context.fetch(fetchRequest).first
            if let favorite = favorite {
                favorite.title = entity.title
                favorite.imgSrc = entity.imgSrc
                favorite.rating = entity.rating
                favorite.released = entity.released
                try context.save()
            }
        }
        return future.eraseToAnyPublisher()
    }

    public func remove(id: IdType) -> AnyPublisher<Void, Error> {
        let future = Future<Void, Error> {
            if id.isEmpty {
                return
            }

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
        return future.eraseToAnyPublisher()
    }

}

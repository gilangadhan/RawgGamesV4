//
//  CoreDataManager.swift
//  RawgGamesV2
//
//  Created by Dhimas Dewanto on 04/02/24.
//

import CoreData
import Foundation

/// Handle Core Data context.
/// Must set as singleton because`container` can only run 1 time.
public class CoreDataManager: ObservableObject {
    public static let manager: CoreDataManager = CoreDataManager()
    private init() {}

    private let coreDataName: String = "GameCoreData"
    private let coreDataExtension: String = "momd"

    lazy public var container: PersistentContainer? = {
        guard let modelURL = Bundle.module.url(
            forResource: coreDataName,
            withExtension: coreDataExtension
        ) else { return  nil }

        guard let model = NSManagedObjectModel(
            contentsOf: modelURL
        ) else { return nil }

        let container = PersistentContainer(
            name: coreDataName,
            managedObjectModel:model
        )

        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        })

        return container
    }()
}

/// Create a subclass of NSPersistentStore Coordinator
open class PersistentContainer: NSPersistentContainer {}

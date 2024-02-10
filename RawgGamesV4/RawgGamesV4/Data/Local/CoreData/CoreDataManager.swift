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
class CoreDataManager: ObservableObject {
    static let manager: CoreDataManager = CoreDataManager()

    let container = NSPersistentContainer(name: "GameCoreData")

    private init() {
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}

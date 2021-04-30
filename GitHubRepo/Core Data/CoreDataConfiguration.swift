//
//  CoreDataController.swift
//  GitHubRepo
//
//  Created by Mostafa Mahmoud on 4/29/21.
//

import UIKit
import CoreData

struct CoreDataConfiguration {
    
    static let shared = CoreDataConfiguration()
    
    fileprivate let modelName = "GitHubRepo"
    let persistentContainer:NSPersistentContainer
    var backgroundContext:NSManagedObjectContext!
    var mainContext:NSManagedObjectContext

    // add config to core data to insert in background
    init (){
        persistentContainer = NSPersistentContainer(name: modelName)
        let description = persistentContainer.persistentStoreDescriptions.first
        description?.type = NSSQLiteStoreType
        persistentContainer.loadPersistentStores{ storeDescription, error in
            guard error == nil else{
                fatalError("Can't Load Persistent Stores")
            }
        }
        mainContext = persistentContainer.viewContext
        mainContext.automaticallyMergesChangesFromParent = true
        mainContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump

        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext = persistentContainer.newBackgroundContext()
        backgroundContext.automaticallyMergesChangesFromParent = true
        backgroundContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump

    }
    
}

//
//  CoreDataConfigurationTest.swift
//  GitHubRepoTests
//
//  Created by Mostafa Mahmoud on 4/29/21.
//

import Foundation
@testable import GitHubRepo
import CoreData

struct CoreDataConfigurationTest {
    
    static let shared = CoreDataConfiguration()
    
    fileprivate let modelName = "GitHubRepo"
    let persistentContainer:NSPersistentContainer
    var backgroundContext:NSManagedObjectContext!
    var mainContext:NSManagedObjectContext

    init (){
        persistentContainer = NSPersistentContainer(name: modelName)
        let description = persistentContainer.persistentStoreDescriptions.first
        description?.type = NSInMemoryStoreType
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


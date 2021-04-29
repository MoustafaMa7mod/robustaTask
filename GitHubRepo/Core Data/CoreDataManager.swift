//
//  CoreDataManager.swift
//  GitHubRepo
//
//  Created by Mostafa Mahmoud on 4/28/21.
//

import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()

    var backgroundContext:NSManagedObjectContext!
    var mainContext:NSManagedObjectContext

    init(mainContext: NSManagedObjectContext = CoreDataConfiguration.shared.mainContext , backgroundContext:NSManagedObjectContext =  CoreDataConfiguration.shared.backgroundContext) {
        self.mainContext = mainContext
        self.backgroundContext = backgroundContext
    }
    
    
    /// Fetch All Stored Requests From the Store
    func fetchAllData()->[Repository]?{
        let fetchReuest:NSFetchRequest<Repository> = Repository.fetchRequest()
        fetchReuest.returnsObjectsAsFaults = false
        var result: [Repository]?
        mainContext.performAndWait {
            result = try? self.mainContext.fetch(fetchReuest)
        }
         
        return result
    }
    
    func insertData(dataModel:[RepositoryModel]){
        let backgroundContext = self.backgroundContext
        backgroundContext?.performAndWait {
            dataModel.forEach { data in
                let repositoryToStore = Repository(context: backgroundContext!)
                repositoryToStore.repositoryName = data.name
                repositoryToStore.repositoryFullName = data.fullName
                repositoryToStore.ownerName = data.owner?.name
                repositoryToStore.ownerAvaterUrl = data.owner?.avatarUrl
            }
            self.saveContext()
        }
    }
    
    func clearDatabase(){
        let backgroundContext = self.backgroundContext
        backgroundContext?.performAndWait {
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = Repository.fetchRequest()
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            let  _ = try? backgroundContext?.execute(deleteRequest)
            print("all data removed successfully")
            
        }
        
    }
    
    fileprivate func saveContext(){
        let backgroundContext = self.backgroundContext
        if let backgroundContext = backgroundContext, backgroundContext.hasChanges{
            print("data saved successfully")
            try? backgroundContext.save()
        }
    }


    
}

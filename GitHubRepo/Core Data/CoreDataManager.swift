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
    let coreDataConfiguration = CoreDataConfiguration(modelName: "GitHubRepo")
    
    /// Fetch All Stored Requests From the Store
    func fetchAll()->[Repository]?{
        let fetchReuest:NSFetchRequest<Repository> = Repository.fetchRequest()
        fetchReuest.returnsObjectsAsFaults = false
        let result = try? self.coreDataConfiguration.viewContext.fetch(fetchReuest)
        return result
    }
    
    func storeResponse(dataModel:[RepositoryModel]){
        let backgroundContext = coreDataConfiguration.backgroundContext
        removeAll()
        backgroundContext?.perform {
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
    
    func removeAll(){
        let backgroundContext = coreDataConfiguration.backgroundContext
        backgroundContext?.perform {
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = Repository.fetchRequest()
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            let  _ = try? backgroundContext?.execute(deleteRequest)
            print("data removed")
            
        }
        
    }
    
    fileprivate func saveContext(){
        let backgroundContext = coreDataConfiguration.backgroundContext
        if let backgroundContext = backgroundContext, backgroundContext.hasChanges{
            print("data saved successfully")
            try? backgroundContext.save()
        }
    }


    
}

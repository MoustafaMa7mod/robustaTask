//
//  CoreDataManager.swift
//  GitHubRepo
//
//  Created by Mostafa Mahmoud on 4/28/21.
//

import UIKit
import CoreData

class CoreDataController {
    
    let persistentContainer:NSPersistentContainer
    var backgroundContext:NSManagedObjectContext!
    var viewContext:NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    init (modelName:String){
        
        let bundle = Bundle(for: type(of: self))
        let modelURL = bundle.url(forResource: modelName, withExtension: "momd")!
        let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL)!
        
        persistentContainer = NSPersistentContainer(name: modelName,managedObjectModel: managedObjectModel)
        load(){ [self] in
            self.backgroundContext = persistentContainer.newBackgroundContext()
            self.configureContexts()
        }
    }

    func configureContexts() {
        viewContext.automaticallyMergesChangesFromParent = true
        backgroundContext.automaticallyMergesChangesFromParent = true
        
        backgroundContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
    }

 
    func load(completion: (()-> Void)? = nil){
        persistentContainer.loadPersistentStores{ storeDescription, error in
            guard error == nil else{
                fatalError("Can't Load Persistent Stores")
            }
             completion? ()
            
        }
        
    }
    
    
}



class CoreDataManager {
    
    static let shared = CoreDataManager()
    let coreDataController = CoreDataController(modelName: "GitHubRepo")
    
    /// Fetch All Stored Requests From the Store
    func fetchAll()->[Repository]?{
        let fetchReuest:NSFetchRequest<Repository> = Repository.fetchRequest()
        let result = try? self.coreDataController.viewContext.fetch(fetchReuest)
        return result
    }
    
    func storeResponse(dataModel:[RepositoryModel]){
        let backgroundContext = coreDataController.backgroundContext
        removeAll()
        backgroundContext?.perform {
            let repositoryToStore = Repository(context: self.coreDataController.backgroundContext)
            dataModel.forEach { data in
                repositoryToStore.repositoryName = data.name
                repositoryToStore.repositoryFullName = data.fullName
                repositoryToStore.ownerName = data.owner?.name
                repositoryToStore.ownerAvaterUrl = data.owner?.avatarUrl
            }

            self.saveContext()

        }
    }
    
    func removeAll(){
        let backgroundContext = coreDataController.backgroundContext
        backgroundContext?.perform {
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = Repository.fetchRequest()
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            let  _ = try? backgroundContext?.execute(deleteRequest)
            print("data removed")
            
        }
        
    }
    
    fileprivate func saveContext(){
        let backgroundContext = coreDataController.backgroundContext
        if let backgroundContext = backgroundContext, backgroundContext.hasChanges{
            print("data saved successfully")
            try? backgroundContext.save()
        }
    }


    
}

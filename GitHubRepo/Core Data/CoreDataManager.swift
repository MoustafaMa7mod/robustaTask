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
    
    
    // Fetch All repositries from core data
    func fetchAllData(_ predicate:NSPredicate?)->[Repository]?{
        let fetchReuest:NSFetchRequest<Repository> = Repository.fetchRequest()
        fetchReuest.returnsObjectsAsFaults = false
        if let predicate = predicate {
            fetchReuest.predicate = predicate
        }
        var result: [Repository]?
        mainContext.performAndWait {
            result = try? self.mainContext.fetch(fetchReuest)
        }
         
        return result
    }
    
    // Fetch 10 item every scroll time
    func fetchPaginationData(_ page:Int?)->[Repository]?{
        let fetchReuest:NSFetchRequest<Repository> = Repository.fetchRequest()
        fetchReuest.returnsObjectsAsFaults = false
        let pageCount = 10
        
        if let page = page {
            fetchReuest.fetchLimit = pageCount
            fetchReuest.fetchOffset = page*pageCount
        }
        var result: [Repository]?
        mainContext.performAndWait {
            result = try? self.mainContext.fetch(fetchReuest)
        }
        
        return result
    }
    
    
    // insert repositry data in core data form api
    func insertData(dataModel:[RepositoryModel]){
        let backgroundContext = self.backgroundContext
        backgroundContext?.performAndWait {
            dataModel.forEach { data in
                let repositoryToStore = Repository(context: backgroundContext!)
                repositoryToStore.repositoryName = data.name
                repositoryToStore.repositoryFullName = data.fullName
                repositoryToStore.repositryDescription = data.description
                repositoryToStore.ownerName = data.owner?.name
                repositoryToStore.ownerAvaterUrl = data.owner?.avatarUrl
            }
            self.saveContext()
        }
    }
    
    // remove all data and clear database
    func clearDatabase(){
        let backgroundContext = self.backgroundContext
        backgroundContext?.performAndWait {
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = Repository.fetchRequest()
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            let  _ = try? backgroundContext?.execute(deleteRequest)
            print("all data removed successfully")
            
        }
        
    }
    
    // save data in cotext
    fileprivate func saveContext(){
        let backgroundContext = self.backgroundContext
        if let backgroundContext = backgroundContext, backgroundContext.hasChanges{
            print("data saved successfully")
            try? backgroundContext.save()
        }
    }


    
}

//
//  CoreDataManager.swift
//  GitHubRepo
//
//  Created by Mostafa Mahmoud on 4/28/21.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    // MARK:- variables
    private let entityName = "Recording"
    
    // MARK: - Core Data Stack
    let persistentContainer: NSPersistentContainer!
    
    //MARK: Init with dependency
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
        
    // MARK: - get form core data
    func retrieveData() {
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        var handlerConnectionArray: [HandlerConnection] = []
        do {
            let result = try managedContext.fetch(fetchRequest)
            print(result)
        } catch {
            print("Failed to get data")
        }
    }
    
    // MARK: - delete all recording form core data
    func deleteData() {
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let results = try managedContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                managedContext.delete(objectData)
            }
            do{
                try managedContext.save()
                print("Data Delete Success")
            }
            catch{
                print(error)
            }
            
        } catch let error {
            print( error)
        }
    }
    

}

//
//  Repository+CoreDataProperties.swift
//  GitHubRepo
//
//  Created by Mostafa Mahmoud on 4/29/21.
//
//

import Foundation
import CoreData


extension Repository {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Repository> {
        return NSFetchRequest<Repository>(entityName: "Repository")
    }
    
    @NSManaged public var repositoryName: String?
    @NSManaged public var repositoryFullName: String?
    @NSManaged public var repositryDescription: String?
    @NSManaged public var ownerName: String?
    @NSManaged public var ownerAvaterUrl: String?

}

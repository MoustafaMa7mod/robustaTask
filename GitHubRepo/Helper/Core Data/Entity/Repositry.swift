//
//  Repositry.swift
//  GitHubRepo
//
//  Created by Mostafa Mahmoud on 4/28/21.
//

import CoreData
import Foundation

class Repositry: NSManagedObject {
    public class func fetchRequest() -> NSFetchRequest<Repositry> {
        return NSFetchRequest<Repositry>(entityName: "Repository")
    }

    @NSManaged var repoFullName: String
    @NSManaged var repoName: String
    @NSManaged var ownerName: String
    @NSManaged var ownerAvatarUrl: String

    func addDataInRecord(with model: RepositoryModel)  {
        guard let repoFullName = model.fullName,
              let repoName = model.name,
              let ownerName = model.owner?.name,
              let ownerAvatarUrl = model.owner?.avatarUrl else {
                fatalError("filed to add data model in core data")
              }

        self.repoFullName = repoFullName
        self.repoName = repoName
        self.ownerName = ownerName
        self.ownerAvatarUrl = ownerAvatarUrl
    }

}

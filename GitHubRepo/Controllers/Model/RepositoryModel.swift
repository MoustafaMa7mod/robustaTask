//
//  RepositoryModel.swift
//  GitHubRepo
//
//  Created by Mostafa Mahmoud on 4/28/21.
//

import Foundation

struct RepositoryModel: Codable {
    
    var name: String?
    var fullName: String?
    var owner: OwnerModel?
    
    private enum CodingKeys : String, CodingKey {
        case name , owner
        case fullName = "full_name"
    }
}

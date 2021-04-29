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
    var description: String?
    var owner: OwnerModel?
    
    private enum CodingKeys : String, CodingKey {
        case name , owner , description
        case fullName = "full_name"
    }
}

struct OwnerModel: Codable {
    var name: String?
    var avatarUrl: String?
    
    private enum CodingKeys : String, CodingKey {
        case name = "login"
        case avatarUrl = "avatar_url"
    }
}

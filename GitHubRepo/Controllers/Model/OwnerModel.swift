//
//  OwnerModel.swift
//  GitHubRepo
//
//  Created by Mostafa Mahmoud on 4/28/21.
//

import Foundation


struct OwnerModel: Codable {
    var name: String?
    var avatarUrl: String?
    
    private enum CodingKeys : String, CodingKey {
        case name = "login"
        case avatarUrl = "avatar_url"
    }
}

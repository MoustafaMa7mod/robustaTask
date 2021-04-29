//
//  RepositoryDetailsViewModel.swift
//  GitHubRepo
//
//  Created by Mostafa Mahmoud on 4/29/21.
//

import Foundation

class RepositoryDetailsViewModel {
    
    var repositryDetails = Repository()
    
    var ownerName: String? {
        didSet {
            ownerName = repositryDetails.ownerName ?? ""
        }
    }
    
    var ownerImage: String? {
        didSet {
            ownerImage = repositryDetails.ownerAvaterUrl ?? ""
        }
    }
    
    var repoName: String? {
        didSet {
            repoName = repositryDetails.repositoryName ?? ""
        }
    }
    
    var repoFullName: String? {
        didSet {
            repoFullName = repositryDetails.repositoryFullName ?? ""
        }
    }
    
    
    var repoDescription: String? {
        didSet {
            repoDescription = repositryDetails.repositryDescription ?? ""
        }
    }
    
    
    init(repositryDetails: Repository) {
        self.repositryDetails = repositryDetails
    }
    
        
}

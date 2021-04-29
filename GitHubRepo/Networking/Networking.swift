//
//  Network.swift
//  GitHubRepo
//
//  Created by Mostafa Mahmoud on 4/28/21.
//

import Foundation
import CoreData

class Networking{
    
    static let shared = Networking(networkRequest: Request.shared)
    private let networkRequest:Request!
    
    init(networkRequest:Request) {
        self.networkRequest = networkRequest
    }

    func getData(completion: @escaping(Bool) -> Void) {
        
        guard let url = URL(string: URLS.repositoriesURL) else {
            return
        }

        Request.shared.request(url: url) { data , error in
            guard error == nil else{
                completion(false)
                return
            }
            
            guard let data = data else {return}
            let repositoryModel = self.decode(type: [RepositoryModel].self, data: data)
            CoreDataManager.shared.storeResponse(dataModel: repositoryModel ?? [])
            completion(true)
            
        }
        
    }
    
    func decode<T:Codable> (type:T.Type , data:Data)->T?{
        let decoder = JSONDecoder()
        do{
            let object = try decoder.decode(type.self, from: data)
            return object
        }catch{
            print("Failed in decoding: \(error)")
            return nil
        }
    }
    
    
    
}

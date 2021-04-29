//
//  Request.swift
//  GitHubRepo
//
//  Created by Mostafa Mahmoud on 4/28/21.
//

import Foundation

class Request{
    static let shared = Request(session: URLSession.shared)
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }

    func request(url:URL , headers:[String:String] = ["Accept":"application/json","Content-Type":"application/json"],completion: @escaping (Data?, Error?)-> Void){
        
        var request = URLRequest(url:url,cachePolicy: .reloadIgnoringLocalCacheData)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let task = session.dataTask(with: request) { (data , response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, error)
                return
            }
//            DispatchQueue.main.async {
                completion(data ,nil)
//            }
        }
        
        task.resume()
        
    }
}
    

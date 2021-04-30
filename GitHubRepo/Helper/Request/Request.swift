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

    func request(url:URL , headers:[String:String] = ["Accept":"application/json","Content-Type":"application/json"],completion: @escaping (Data?, String?)-> Void){
        
        var request = URLRequest(url:url,cachePolicy: .reloadIgnoringLocalCacheData)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let task = session.dataTask(with: request) { (data , response, error) in
            guard error == nil,
                let response = response as? HTTPURLResponse else {
                completion(nil, error?.localizedDescription ?? "Something went wrong!")
                return
            }
            switch response.statusCode {
            case 200:
                guard let data = data else {
                    return
                }
                completion(data ,nil)
            case 403:
                completion(nil, error?.localizedDescription ?? "API rate limit exceed")
            default:
                completion(nil, error?.localizedDescription ?? "Something went wrong!")
                break
            }
        }
        
        task.resume()
        
    }
}
    

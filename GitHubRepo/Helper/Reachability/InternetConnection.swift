//
//  InternetConnection.swift
//  GitHubRepo
//
//  Created by Mostafa Mahmoud on 4/30/21.
//

import Foundation
@objc class InternetConnection: NSObject {
    
    @objc static let internetConnection = InternetConnection()
    let reachability = Reachability()!
    static var isConnectedToInternet:Bool?
    
    @objc func checkInternetConnection(){
        reachability.whenReachable = { reachability in
            InternetConnection.isConnectedToInternet = true
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "internet"), object: self, userInfo: ["isConnected": true])
            if reachability.connection == .wifi {
                print("[network] Reachable via WiFi")
            } else {
                print("[network] Reachable via cellular")
            }
        }
        reachability.whenUnreachable = { _ in
            print("[network] Not reachable")
            InternetConnection.isConnectedToInternet = false
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "internet"), object: self, userInfo: ["isConnected": false])
            print("[network] not internet")
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
}

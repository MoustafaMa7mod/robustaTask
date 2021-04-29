//
//  HomeViewModel.swift
//  GitHubRepo
//
//  Created by Mostafa Mahmoud on 4/29/21.
//

import Foundation


class HomeViewModel {
    
    var repositryArray = [Repository]()
    
    func getDataFromAPI(completion: @escaping(String?)-> Void)  {
        repositryArray = CoreDataManager.shared.fetchAllData() ?? []

        if repositryArray.count == 0 {
            Networking.shared.getData { [weak self]loadData in
                print("load data from api")
                if loadData {
                    self?.repositryArray = CoreDataManager.shared.fetchAllData() ?? []
                    completion(nil)
                }else{
                    completion("Faild To load Data From API")
                }
                
            }
        }
        
    }
    
    func getCountOfRepositryArray() -> Int {
        return repositryArray.count
    }
    
    func getDetailsOfEachRepositry(_ index: Int) -> Repository{
        return repositryArray[index]
    }
    
    
    
    
    
}

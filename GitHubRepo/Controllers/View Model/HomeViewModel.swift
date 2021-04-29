//
//  HomeViewModel.swift
//  GitHubRepo
//
//  Created by Mostafa Mahmoud on 4/29/21.
//

import Foundation


class HomeViewModel {
    
    var repositriesArray = [Repository]()
    var repositriesArrayFilter = [Repository]()

    func getDataFromAPI(completion: @escaping(String?)-> Void)  {
        repositriesArray = CoreDataManager.shared.fetchAllData() ?? []
        repositriesArrayFilter = repositriesArray

        if repositriesArray.count == 0 {
            Networking.shared.getData { [weak self]loadData in
                print("load data from api")
                if loadData {
                    self?.repositriesArray = CoreDataManager.shared.fetchAllData() ?? []
                    self?.repositriesArrayFilter = self?.repositriesArray ?? []
                    completion(nil)
                }else{
                    completion("Faild To load Data From API")
                }
                
            }
        }
        
    }
    
    func searchRepositryName(_ name: String) {
        self.repositriesArrayFilter.removeAll()
        if name.count != 0 {
            for repo in self.repositriesArray {
                if let repoName = repo.repositoryName {
                    let range = repoName.lowercased().range(of: name.lowercased(), options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil {
                        self.repositriesArrayFilter.append(repo)
                    }
                }
                
            }
        }else{
            for repo in self.repositriesArray {
                self.repositriesArrayFilter.append(repo)
            }
        }
    }
    
    func getCountOfRepositryArray() -> Int {
        return repositriesArrayFilter.count
    }
    
    func getDetailsOfEachRepositry(_ index: Int) -> Repository{
        return repositriesArrayFilter[index]
    }
    
    
    
    
    
}

//
//  HomeViewModel.swift
//  GitHubRepo
//
//  Created by Mostafa Mahmoud on 4/29/21.
//

import Foundation


class RepositoryViewModel {
    
    var repositriesArray = [Repository]()
    var repositriesArrayFilter = [Repository]()
    
    var pageCount = 1
    
    var totalResultsCount: Int {
        return CoreDataManager.shared.fetchAllData()?.count ?? 0
    }

    
    func getDataFromAPI(completion: @escaping(String?)-> Void)  {
        repositriesArray = CoreDataManager.shared.fetchPaginationData(pageCount) ?? []
        repositriesArrayFilter = repositriesArray

        if repositriesArray.count == 0 {
            Networking.shared.getData { [weak self] loadData in
                print("load data from api")
                if loadData {
                    self?.repositriesArray = CoreDataManager.shared.fetchPaginationData(self?.pageCount) ?? []
                    self?.repositriesArrayFilter = self?.repositriesArray ?? []
                    completion(nil)
                }else{
                    completion("Faild To load Data From API")
                }
                
            }
        }
        
    }
    
    func loadModreData(){
        pageCount = pageCount + 1
        repositriesArray += CoreDataManager.shared.fetchPaginationData(pageCount) ?? []
        repositriesArrayFilter = repositriesArray
    }
    
    func searchRepositryName(_ name: String) {
        if name.count != 0 {
            self.repositriesArrayFilter = repositriesArray.filter { (repo: Repository) -> Bool in
                return repo.repositoryName?.lowercased().contains(name.lowercased()) ?? false
            }
        }else{
            self.repositriesArrayFilter = self.repositriesArray
        }
        
    }
    
    func getCountOfRepositryArray() -> Int {
        return repositriesArrayFilter.count
    }
    
    func getDetailsOfEachRepositry(_ index: Int) -> Repository{
        return repositriesArrayFilter[index]
    }
    
    
    
    
    
}

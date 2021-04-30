//
//  HomeViewModel.swift
//  GitHubRepo
//
//  Created by Mostafa Mahmoud on 4/29/21.
//

import Foundation


class RepositoryViewModel {
    
    // MARK:- varaibles
    var repositriesArray = [Repository]()
    var repositriesArrayFilter = [Repository]()
    var pageCount = 1

    
    // MARK:- load data
    
    // first time data get from api and store in core data then data loaded from core data every time when scroll
    func getDataFromAPI(completion: @escaping(String?)-> Void)  {
        repositriesArray = CoreDataManager.shared.fetchPaginationData(pageCount) ?? []
        repositriesArrayFilter = repositriesArray

        if repositriesArray.count == 0 {
            Networking.shared.getData { [weak self] loadData , errorMessage  in
                print("load data from api")
                if loadData {
                    self?.repositriesArray = CoreDataManager.shared.fetchPaginationData(self?.pageCount) ?? []
                    self?.repositriesArrayFilter = self?.repositriesArray ?? []
                    completion(nil)
                }else{
                    completion(errorMessage)
                }
                
            }
        }
        
    }
    
    // load pagination data (10 records every time)
    func loadModreData(){
        pageCount = pageCount + 1
        repositriesArray += CoreDataManager.shared.fetchPaginationData(pageCount) ?? []
        repositriesArrayFilter = repositriesArray
    }
    
    
    //MARK:- search Repositry name
    // search in loaded data about reposity name when start weite in search field list will update and show filter data
    func searchRepositryName(_ name: String) {
        if name.count != 0 {
            self.repositriesArrayFilter = repositriesArray.filter { (repo: Repository) -> Bool in
                return repo.repositoryName?.lowercased().contains(name.lowercased()) ?? false
            }
        }else{
            self.repositriesArrayFilter = self.repositriesArray
        }
        
    }
    
    
    // MARK:- get total list count
    func getCountOfRepositryArray() -> Int {
        return repositriesArrayFilter.count
    }
    
    
    // MARK:- get each repositry details
    func getDetailsOfEachRepositry(_ index: Int) -> Repository{
        return repositriesArrayFilter[index]
    }
    
    
    
    
    
}

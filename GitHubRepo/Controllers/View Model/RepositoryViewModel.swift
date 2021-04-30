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
                if loadData {
                    print("load data from api")
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
    
    // search with NSPredicate core data
    func loadDataWithPredicate(_ searchName: String){
        pageCount = 1
        self.repositriesArrayFilter = CoreDataManager.shared.fetchAllData(NSPredicate(format: "repositoryName CONTAINS[c] %@", "\(searchName)")) ?? []
    }
    
    
    //MARK:- search Repositry name
    // search in loaded data about reposity name when start weite in search field list will update and show filter data
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
    
    
    // MARK:- get total list count
    func getCountOfRepositryArray() -> Int {
        return repositriesArrayFilter.count
    }
    
    
    // MARK:- get each repositry details
    func getDetailsOfEachRepositry(_ index: Int) -> Repository{
        return repositriesArrayFilter[index]
    }
    
    
    
    
    
}

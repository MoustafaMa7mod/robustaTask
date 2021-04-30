//
//  CoreDataManagerTest.swift
//  GitHubRepoTests
//
//  Created by Mostafa Mahmoud on 4/29/21.
//

import XCTest
@testable import GitHubRepo
import CoreData

class CoreDataManagerTest: XCTestCase {

    var coreDataManager: CoreDataManager!
    var coreDataConfigurationTest: CoreDataConfigurationTest!
    
    override func setUpWithError() throws {
        coreDataConfigurationTest =  CoreDataConfigurationTest()
        coreDataManager = CoreDataManager(mainContext: coreDataConfigurationTest.mainContext , backgroundContext: coreDataConfigurationTest.mainContext)
    }

    override func tearDownWithError() throws {
        coreDataConfigurationTest = nil
        coreDataManager = nil

    }

    func test_insert_data(){
        let dataModel = [RepositoryModel(name: "grit", fullName: "mojombo/grit" , description: "**Grit is no longer maintained." , owner: OwnerModel(name: "mojombo", avatarUrl: "https://avatars.githubusercontent.com/u/1?v=4"))]
        coreDataManager.insertData(dataModel: dataModel)
        let repo = coreDataManager.fetchPaginationData(nil)
        XCTAssertEqual(repo![0].repositoryName, "grit")
    }
    
    func test_get_pagination_data(){
        let dataModel = [RepositoryModel(name: "grit", fullName: "mojombo/grit" , description: "**Grit is no longer maintained." , owner: OwnerModel(name: "mojombo", avatarUrl: "https://avatars.githubusercontent.com/u/1?v=4")) , RepositoryModel(name: "merb-core", fullName: "wycats/merb-core", description: "Merb Core: All you need. None you don't." , owner: OwnerModel(name: "wycats", avatarUrl: "https://avatars.githubusercontent.com/u/4?v=4"))]
        coreDataManager.insertData(dataModel: dataModel)
        let repo = coreDataManager.fetchPaginationData(nil)
        XCTAssertEqual(repo?.count , 2)
    }

    func test_get_all_data(){
        let dataModel = [RepositoryModel(name: "grit", fullName: "mojombo/grit" , description: "**Grit is no longer maintained." , owner: OwnerModel(name: "mojombo", avatarUrl: "https://avatars.githubusercontent.com/u/1?v=4")) , RepositoryModel(name: "merb-core", fullName: "wycats/merb-core", description: "Merb Core: All you need. None you don't." , owner: OwnerModel(name: "wycats", avatarUrl: "https://avatars.githubusercontent.com/u/4?v=4"))]
        coreDataManager.insertData(dataModel: dataModel)
        let repo = coreDataManager.fetchAllData(NSPredicate(format: "repositoryName CONTAINS[c] %@", "grit"))
        XCTAssertEqual(repo?.count , 1)
    }

    
    
}

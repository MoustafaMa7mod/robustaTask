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
    
    override func setUp() {
        super.setUp()
        coreDataConfigurationTest =  CoreDataConfigurationTest()
        coreDataManager = CoreDataManager(mainContext: coreDataConfigurationTest.mainContext , backgroundContext: coreDataConfigurationTest.mainContext)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataConfigurationTest = nil
        coreDataManager = nil
    }
    
    func test_insert_data(){
        let dataModel = [RepositoryModel(name: "grit", fullName: "mojombo/grit", owner: OwnerModel(name: "mojombo", avatarUrl: "https://avatars.githubusercontent.com/u/1?v=4"))]
        coreDataManager.insertData(dataModel: dataModel)
        let repo = coreDataManager.fetchAllData()
        XCTAssertEqual(repo![0].repositoryName, "grit")
    }
    
    func test_get_all_data(){
        let dataModel = [RepositoryModel(name: "grit", fullName: "mojombo/grit", owner: OwnerModel(name: "mojombo", avatarUrl: "https://avatars.githubusercontent.com/u/1?v=4")) , RepositoryModel(name: "merb-core", fullName: "wycats/merb-core", owner: OwnerModel(name: "wycats", avatarUrl: "https://avatars.githubusercontent.com/u/4?v=4"))]
        coreDataManager.insertData(dataModel: dataModel)
        let repo = coreDataManager.fetchAllData()
        XCTAssertEqual(repo?.count , 2)
    }
    
//    func test_clear_data_base(){
//        let dataModel = [RepositoryModel(name: "grit", fullName: "mojombo/grit", owner: OwnerModel(name: "mojombo", avatarUrl: "https://avatars.githubusercontent.com/u/1?v=4")) , RepositoryModel(name: "merb-core", fullName: "wycats/merb-core", owner: OwnerModel(name: "wycats", avatarUrl: "https://avatars.githubusercontent.com/u/4?v=4"))]
//        coreDataManager.insertData(dataModel: dataModel)
//        coreDataManager.clearDatabase()
//        let repo = coreDataManager.fetchAllData()
//        XCTAssertNotEqual(repo?.count, 2)
//    }
    
    
   

}

//
//  RepositoryViewModelTest.swift
//  GitHubRepoTests
//
//  Created by Mostafa Mahmoud on 4/30/21.
//

import XCTest
@testable import GitHubRepo


class RepositoryViewModelTest: XCTestCase {

    var repositoryViewModel: RepositoryViewModel!
    
    override func setUpWithError() throws {
        repositoryViewModel = RepositoryViewModel()
    }

    override func tearDownWithError() throws {
        repositoryViewModel = nil
    }
    
    func test_count_of_empty_repositries_arraies(){
        XCTAssertEqual(repositoryViewModel.repositriesArrayFilter.count, 0)
        XCTAssertEqual(repositoryViewModel.repositriesArray.count, 0)

    }
    
    func test_get_from_api_wehn_empty_repositries_arraies(){
        let count = repositoryViewModel.repositriesArray.count
        if count == 0 {
            var actualData: Bool?
            var errorMessage: String?
            let exp = expectation(description: "request")
            Networking.shared.getData { loadData , message in
                actualData = loadData
                errorMessage = message
                exp.fulfill()
            }
            waitForExpectations(timeout: 2, handler: nil)
            XCTAssertTrue(actualData!)
            XCTAssertNil(errorMessage)

        }
    }
    
    func test_count_of_repositries_array(){
        repositoryViewModel.getDataFromAPI { message in
            
        }
        XCTAssertNotEqual(repositoryViewModel.repositriesArrayFilter.count, 0)
        XCTAssertNotEqual(repositoryViewModel.repositriesArray.count, 0)
    }
    
    func test_details_of_repositries_array(){
        repositoryViewModel.getDataFromAPI { message in
            
        }
        let data = repositoryViewModel.getDetailsOfEachRepositry(0)
        XCTAssertNotNil(data)
    }
}

//
//  NetworkingTest.swift
//  GitHubRepoTests
//
//  Created by Mostafa Mahmoud on 4/29/21.
//

import XCTest
@testable import GitHubRepo

class NetworkingTest: XCTestCase {
    
    var networking:Networking!
    let session = MockURLSession()

    
    override func setUpWithError() throws {
        let request = Request(session: session)
        networking = Networking(networkRequest: request)

    }
   
    override func tearDownWithError() throws {
        networking = nil
    }

    func test_get_should_return_data() {
        let expectedData = "{}".data(using: .utf8)
        
        session.nextData = expectedData
        
        var actualData: Bool?
        let exp = expectation(description: "request")
        networking.getData { loadData in
            actualData = loadData
            exp.fulfill()

        }
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertTrue(actualData!)
        XCTAssertNotNil(actualData)
    }

}

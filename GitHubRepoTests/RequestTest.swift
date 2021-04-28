//
//  RequestTest.swift
//  GitHubRepoTests
//
//  Created by Mostafa Mahmoud on 4/28/21.
//

import XCTest
@testable import GitHubRepo

class RequestTest: XCTestCase {

    var request: Request!
    let session = MockURLSession()
    
    override func setUp() {
        super.setUp()
        request = Request(session: session)
    }
    func test_get_request_with_URL() {

        guard let url = URL(string: URLS.repositoriesURL) else {
            fatalError("URL can't be empty")
        }
        
        request.request(url: url) { (data ,error) in
            // Return data
        }
        
        XCTAssert(session.lastURL == url)
        
    }
    
    func test_get_resume_called() {
        
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        
        guard let url = URL(string: URLS.repositoriesURL) else {
            fatalError("URL can't be empty")
        }
        
        request.request(url: url) { (data ,error) in
            // Return data
        }

        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func test_get_should_return_data() {
        let expectedData = "{}".data(using: .utf8)
        
        session.nextData = expectedData
        
        var actualData: Data?
        guard let url = URL(string: URLS.repositoriesURL) else {
            fatalError("URL can't be empty")
        }
        let exp = expectation(description: "request")
         request.request(url: url) { (data ,error) in
            
            actualData = data
            exp.fulfill()
        }
         
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertNotNil(actualData)
    }


}

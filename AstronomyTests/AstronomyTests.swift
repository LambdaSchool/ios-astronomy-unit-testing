//
//  AstronomyTests.swift
//  AstronomyTests
//
//  Created by Karen Rodriguez on 4/20/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import XCTest
@testable import Astronomy

class MarsRoverClientTests: XCTestCase {
    
    func testFetchMethods() {
        let expectation = self.expectation(description: "Wait for results")
        
        let controller = MarsRoverClient()
        var foundRover: MarsRover?
        
        controller.fetchMarsRover(named: "curiosity") { rover, error in
            print("We got back some results!")
            
            guard let rover = rover else {
                return
            }
            
            foundRover = rover
            
            XCTAssertNotNil(rover)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
        
        let expectation2 = self.expectation(description: "Wait for results")
        
        controller.fetchPhotos(from: foundRover!, onSol: 1) { (photoReference, error) in
            guard let photos = photoReference else { return }
            
            XCTAssertNotNil(photos)
            expectation2.fulfill()
            
        }
        
        wait(for: [expectation2], timeout: 10)
    }
    
    func testloadDataMethods() {
        let dataExpectation = self.expectation(description: "testy testy")
        let errorExpectation = self.expectation(description: "testy testy")
        let dataLoader = MockLoader(data: Data())
        
        dataLoader.loadData(from: URL(string: "nowherebro.com")!) { (data, error) in
            XCTAssertNotNil(data)
            XCTAssertNil(error)
            dataExpectation.fulfill()
        }
        
        let errorLoader = MockLoader(error: NSError(domain: "", code: 1, userInfo: nil) )
        
        errorLoader.loadData(from: URL(string: "nowherebro.com")!) { (data, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(data)
            errorExpectation.fulfill()
        }
        
        wait(for: [dataExpectation, errorExpectation], timeout: 5)
    }
    
    func testloadValidRover() {
        let dataExpectation = self.expectation(description: "testy testy")
        let dataLoader = MockLoader(data: validRoverJSON)
        let client = MarsRoverClient(networkLoader: dataLoader)
        
        client.fetchMarsRover(named: "testting") { (rover, error) in
            XCTAssertNotNil(rover)
            XCTAssertNil(error)
            dataExpectation.fulfill()
        }
        wait(for: [dataExpectation], timeout: 5)
    }
}

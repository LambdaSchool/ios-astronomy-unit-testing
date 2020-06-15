//
//  MarsRoverClientTests.swift
//  AstronomyTests
//
//  Created by Enzo Jimenez-Soto on 6/15/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import XCTest
@testable import Astronomy

class MockDataLoader: NetworkDataLoader {
    
    var data: Data?
    var error: Error?
    
    func loadData(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        DispatchQueue.main.async {
            completion(self.data, self.error)
        }
    }
    
    func loadData(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
        DispatchQueue.main.async {
            completion(self.data, self.error)
        }
    }
}


class MarsRoverClientTests: XCTestCase {
    
    
    var result: MarsRover?
    var error: Error?
    var photoFetchResults: [MarsPhotoReference] = []
    
    func testMarsRoverFetchOfGoodData() {
        
        let mockLoader = MockDataLoader()
        mockLoader.data = validRoverJSON
        

        let marsRoverClient = MarsRoverClient(networkLoader: mockLoader)
        
        let e = expectation(description: "Wait for results")
        

        marsRoverClient.fetchMarsRover(named: "Curiosity") { (data, error) in
            

            guard let data = data else { fatalError("No data has been returned") }
            self.result = data
            
            e.fulfill()
        }
        
     
        wait(for: [e], timeout: 2)
        
        
        guard let result = result else { fatalError("No result has been returned") }
        XCTAssertEqual(result.name, "Curiosity")
        XCTAssertEqual(result.numberOfPhotos, 4156)
        
    }
    
    
    func testMarsRoverFetchDecodingFailsForBadData() {
        let mockLoader = MockDataLoader()
        mockLoader.data = invalidRoverJSON
        
        let marsRoverClient = MarsRoverClient(networkLoader: mockLoader)
        
        let e = expectation(description: "Wait for results")
        
        marsRoverClient.fetchMarsRover(named: "Curiosity") { (data, error) in
            
            self.result = data
            e.fulfill()
        }
        wait(for: [e], timeout: 2)
        
        XCTAssertTrue(result == nil)
        
    }
}

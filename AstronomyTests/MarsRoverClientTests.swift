//
//  MarsRoverClientTests.swift
//  AstronomyTests
//
//  Created by Linh Bouniol on 9/17/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import XCTest
@testable import Astronomy

class MockLoader: NetworkDataLoader {
    
    let data: Data?
    let error: Error?
    
    init(data: Data?, error: Error?) {
        self.data = data
        self.error = error
    }
    
    private(set) var request: URLRequest? = nil
    private(set) var url: URL? = nil
    
    func loadData(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        self.request = request
        
        DispatchQueue.global().async {
            completion(self.data, self.error)
        }
    }
    
    func loadData(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
        self.url = url
        
        DispatchQueue.global().async {
            completion(self.data, self.error)
        }
    }
}

func urlComponents(_ components1: URLComponents, equalTo components2: URLComponents) -> Bool {
    var scratch1 = components1
    var scratch2 = components2
    
    scratch1.queryItems = []
    scratch2.queryItems = []
    if scratch1 != scratch2 {
        return false
    }
    
    // Compare query items
    if let queryItems1 = components1.queryItems,
        let queryItems2 = components2.queryItems {
        if Set(queryItems1) != Set(queryItems2) {
            return false
        }
    }
    
    return true
}

class MarsRoverClientTests: XCTestCase {
    
    let marsRoverSample = MarsRover(name: "Curiosity", launchDate: Date(), landingDate: Date(), status: .active, maxSol: 10, maxDate: Date(), numberOfPhotos: 4156, solDescriptions: [SolDescription(sol: 0, totalPhotos: 3702, cameras: ["CHEMCAM"])])
    
    func testFetchMarsRover() {
        
        let mock = MockLoader(data: validRoverJSON, error: nil)
        let marsRoverClient = MarsRoverClient(networkLoader: mock)
        
        let expectation = self.expectation(description: "Fetch Mars Rover")
        
        marsRoverClient.fetchMarsRover(named: marsRoverSample.name) { (marsRover, error) in
            
            XCTAssertNotNil(mock.url)
            
            let components = URLComponents(url: mock.url!, resolvingAgainstBaseURL: true)!
            let testComponents = URLComponents(url: URL(string: "https://api.nasa.gov/mars-photos/api/v1/manifests/Curiosity?api_key=qzGsj0zsKk6CA9JZP1UjAbpQHabBfaPg2M5dGMB7")!, resolvingAgainstBaseURL: true)!
            XCTAssertTrue(urlComponents(components, equalTo: testComponents))
            
            // check anything
            XCTAssertEqual(marsRover?.maxSol, self.marsRoverSample.maxSol)
            XCTAssertEqual(marsRover?.name, self.marsRoverSample.name)
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testFetchPhotos() {
        
        let mock = MockLoader(data: validSol1JSON, error: nil)
        let marsRoverClient = MarsRoverClient(networkLoader: mock)
        
        let expectation = self.expectation(description: "Fetch Photos")
        
        marsRoverClient.fetchPhotos(from: marsRoverSample, onSol: 1) { (photos, error) in
            
            XCTAssertNotNil(mock.url)
            
            let components = URLComponents(url: mock.url!, resolvingAgainstBaseURL: true)!
            let testComponents = URLComponents(url: URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/Curiosity/photos?sol=1&api_key=qzGsj0zsKk6CA9JZP1UjAbpQHabBfaPg2M5dGMB7")!, resolvingAgainstBaseURL: true)!
            XCTAssertTrue(urlComponents(components, equalTo: testComponents))
            
            XCTAssertNotNil(photos)
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}

//
//  MarsRoverClientTests.swift
//  AstronomyTests
//
//  Created by Dillon McElhinney on 10/22/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import XCTest
@testable import Astronomy

class MarsRoverClientTests: XCTestCase {

    func testFetchingRoverWithValidData() {
        let mockLoader = MockLoader(data: validRoverJSON, error: nil)
        let marsRoverClient = MarsRoverClient(networkLoader: mockLoader)
        let correctURL = URL(string: "https://api.nasa.gov/mars-photos/api/v1/manifests/curiosity?api_key=qzGsj0zsKk6CA9JZP1UjAbpQHabBfaPg2M5dGMB7")!
        
        let roverExpectation = expectation(description: "Load Rover Expectation")
        marsRoverClient.fetchMarsRover(named: "curiosity") { (rover, error) in
            XCTAssertNil(error)
            XCTAssertEqual(rover?.name, "Curiosity")
            XCTAssertEqual(rover?.maxSol, 10)
            XCTAssertEqual(rover?.solDescriptions.count, 5)
            XCTAssertEqual(mockLoader.url, correctURL)
            
            roverExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 3)
    }
    
    func testFetchingRoverWithInvalidData() {
        let mockLoader = MockLoader(data: invalidRoverJSON, error: nil)
        let marsRoverClient = MarsRoverClient(networkLoader: mockLoader)
        let correctURL = URL(string: "https://api.nasa.gov/mars-photos/api/v1/manifests/curiosity?api_key=qzGsj0zsKk6CA9JZP1UjAbpQHabBfaPg2M5dGMB7")!
        let roverExpectation = expectation(description: "Load Rover Expectation")
        marsRoverClient.fetchMarsRover(named: "curiosity") { (rover, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(rover)
            XCTAssertEqual(mockLoader.url, correctURL)
            
            roverExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 3)
    }
    
    func testFetchingRoverWithNoData() {
        let mockLoader = MockLoader(data: nil, error: nil)
        let marsRoverClient = MarsRoverClient(networkLoader: mockLoader)
        let correctURL = URL(string: "https://api.nasa.gov/mars-photos/api/v1/manifests/curiosity?api_key=qzGsj0zsKk6CA9JZP1UjAbpQHabBfaPg2M5dGMB7")!
        let roverExpectation = expectation(description: "Load Rover Expectation")
        marsRoverClient.fetchMarsRover(named: "curiosity") { (rover, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(rover)
            XCTAssertEqual(mockLoader.url, correctURL)
            
            roverExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 3)
    }
    
    func testFetchingRoverWithError() {
        let error = NSError(domain: "com.LambdaSchool.Astronomy.ErrorDomain", code: -1, userInfo: nil)
        let mockLoader = MockLoader(data: nil, error: error)
        let marsRoverClient = MarsRoverClient(networkLoader: mockLoader)
        let correctURL = URL(string: "https://api.nasa.gov/mars-photos/api/v1/manifests/curiosity?api_key=qzGsj0zsKk6CA9JZP1UjAbpQHabBfaPg2M5dGMB7")!
        
        let roverExpectation = expectation(description: "Load Rover Expectation")
        marsRoverClient.fetchMarsRover(named: "curiosity") { (rover, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(rover)
            XCTAssertEqual(mockLoader.url, correctURL)
            
            roverExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 3)
    }
    
    func testFetchingPhotosWithValidData() {
        let marsRoverDict = try? MarsPhotoReference.jsonDecoder.decode([String: MarsRover].self, from: validRoverJSON)

        guard let marsRover = marsRoverDict?["photoManifest"] else {
            XCTFail()
            return
        }
        
        let mockLoader = MockLoader(data: validSol1JSON, error: nil)
        let marsRoverClient = MarsRoverClient(networkLoader: mockLoader)
        let correctURL = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/Curiosity/photos?sol=1&api_key=qzGsj0zsKk6CA9JZP1UjAbpQHabBfaPg2M5dGMB7")!
        
        let photoExpectation = expectation(description: "Load Photo Expectation")
        marsRoverClient.fetchPhotos(from: marsRover, onSol: 1) { (photos, error) in
            XCTAssertNil(error)
            XCTAssertEqual(photos?.count, 16)
            XCTAssertEqual(photos?[0].camera.name, "MAST")
            XCTAssertEqual(photos?[4].camera.name, "MAHLI")
            XCTAssertEqual(mockLoader.url, correctURL)
            
            photoExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 3)
    }
    
    func testFetchingPhotosWithInvalidData() {
        let marsRoverDict = try? MarsPhotoReference.jsonDecoder.decode([String: MarsRover].self, from: validRoverJSON)
        
        guard let marsRover = marsRoverDict?["photoManifest"] else {
            XCTFail()
            return
        }
        
        let mockLoader = MockLoader(data: invalidSol1JSON, error: nil)
        let marsRoverClient = MarsRoverClient(networkLoader: mockLoader)
        let correctURL = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/Curiosity/photos?sol=1&api_key=qzGsj0zsKk6CA9JZP1UjAbpQHabBfaPg2M5dGMB7")!
        
        let photoExpectation = expectation(description: "Load Photo Expectation")
        marsRoverClient.fetchPhotos(from: marsRover, onSol: 1) { (photos, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(photos)
            XCTAssertEqual(mockLoader.url, correctURL)
            
            photoExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 3)
    }
    
    func testFetchingPhotosWithNoData() {
        let marsRoverDict = try? MarsPhotoReference.jsonDecoder.decode([String: MarsRover].self, from: validRoverJSON)
        
        guard let marsRover = marsRoverDict?["photoManifest"] else {
            XCTFail()
            return
        }
        
        let mockLoader = MockLoader(data: nil, error: nil)
        let marsRoverClient = MarsRoverClient(networkLoader: mockLoader)
        let correctURL = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/Curiosity/photos?sol=1&api_key=qzGsj0zsKk6CA9JZP1UjAbpQHabBfaPg2M5dGMB7")!
        
        let photoExpectation = expectation(description: "Load Photo Expectation")
        marsRoverClient.fetchPhotos(from: marsRover, onSol: 1) { (photos, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(photos)
            XCTAssertEqual(mockLoader.url, correctURL)
            
            photoExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 3)
    }

}

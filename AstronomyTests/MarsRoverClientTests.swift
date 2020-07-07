//
//  MarsRoverClientTests.swift
//  AstronomyTests
//
//  Created by Chad Parker on 6/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import XCTest
@testable import Astronomy

class MarsRoverClientTests: XCTestCase {
   
   //fetchMarsRover()
   //fetchPhotos()
   
   func testFetchMarsRoverMock() {
      let marsRoverClient = MarsRoverClient()
      let expectation = self.expectation(description: "Waiting for Rover API")
      
      let mockLoader = MockLoader(data: validRoverJSON, error: nil)
      marsRoverClient.fetchMarsRover(named: "curiosity", using: mockLoader) { possibleRover, possibleError in
         if let error = possibleError {
            dump(error)
         }
         XCTAssertNil(possibleError)
         XCTAssertNotNil(possibleRover)
         
         let rover = possibleRover!
         XCTAssert(rover.numberOfPhotos > 0)
         
         expectation.fulfill()
      }
      wait(for: [expectation], timeout: 5)
   }
   
   func testFetchMarsRoverNetwork() {
      let marsRoverClient = MarsRoverClient()
      let expectation = self.expectation(description: "Waiting for Rover API")
      
      marsRoverClient.fetchMarsRover(named: "curiosity") { possibleRover, possibleError in
         if let error = possibleError {
            dump(error)
         }
         XCTAssertNil(possibleError)
         XCTAssertNotNil(possibleRover)
         
         let rover = possibleRover!
         XCTAssert(rover.numberOfPhotos > 0)
         
         expectation.fulfill()
      }
      wait(for: [expectation], timeout: 5)
   }
   
   func testFetchPhotosMock() {
      let marsRoverClient = MarsRoverClient()
      let expectation = self.expectation(description: "Waiting for API")
      
      let mockRoverLoader = MockLoader(data: validRoverJSON, error: nil)
      marsRoverClient.fetchMarsRover(named: "curiosity", using: mockRoverLoader) { possibleRover, possibleError in
         XCTAssertNil(possibleError)
         XCTAssertNotNil(possibleRover)
         
         let mockPhotosLoader = MockLoader(data: validSol1JSON, error: nil)
         marsRoverClient.fetchPhotos(from: possibleRover!, onSol: 1, using: mockPhotosLoader) { possibleMarsPhotoReferences, possibleError in
            if let error = possibleError {
               dump(error)
            }
            XCTAssertNil(possibleError)
            XCTAssertNotNil(possibleMarsPhotoReferences)
            
            let marsPhotoReferences = possibleMarsPhotoReferences!
            XCTAssert(marsPhotoReferences.count > 0)
            
            expectation.fulfill()
         }
      }
      
      wait(for: [expectation], timeout: 5)
   }
   
   func testFetchPhotosNetwork() {
      let marsRoverClient = MarsRoverClient()
      let expectation = self.expectation(description: "Waiting for API")
      
      marsRoverClient.fetchMarsRover(named: "curiosity") { possibleRover, possibleError in
         XCTAssertNil(possibleError)
         XCTAssertNotNil(possibleRover)
         
         marsRoverClient.fetchPhotos(from: possibleRover!, onSol: 0) { possibleMarsPhotoReferences, possibleError in
            if let error = possibleError {
               dump(error)
            }
            XCTAssertNil(possibleError)
            XCTAssertNotNil(possibleMarsPhotoReferences)
            
            let marsPhotoReferences = possibleMarsPhotoReferences!
            XCTAssert(marsPhotoReferences.count > 0)
            
            expectation.fulfill()
         }
      }
      
      wait(for: [expectation], timeout: 40) // this takes too long! has to be over 30 seconds to pass.
   }
}

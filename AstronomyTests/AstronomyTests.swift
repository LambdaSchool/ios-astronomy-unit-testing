//
//  AstronomyTests.swift
//  AstronomyTests
//
//  Created by Gladymir Philippe on 9/30/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import XCTest
@testable import Astronomy

class AstronomyTests: XCTestCase {
    
    

    func testMarsRover() {
            let mockDataTask = MockLoader(data: validRoverJSON, error: nil)
            let marsRoverClient = MarsRoverClient(networkLoader: mockDataTask)
            let expectation = self.expectation(description: "Wait for completion of Rover Data")

            marsRoverClient.fetchMarsRover(named: "Curiosity") { (marsRover, error) in
                XCTAssertNil(error)
                guard let rover = marsRover else {
                    XCTFail("Error getting marsRover data")
                    return
                }
                XCTAssertEqual(rover.name, "Curiosity")
                XCTAssertEqual(rover.numberOfPhotos, 4156)

                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 5)
        }

        func testFetchPhotos() {
            // Getting our Rover like above
            let mockRoverDataTask = MockLoader(data: validRoverJSON, error: nil)
            var marsRoverClient = MarsRoverClient(networkLoader: mockRoverDataTask)
            let fetchRoverExpectation = self.expectation(description: "Wait for Rover data")
            var rover: MarsRover?

            marsRoverClient.fetchMarsRover(named: "Curiosity") { (marsRover, error) in
                guard let marsRover = marsRover else {
                    XCTFail("Mars Rover data returns nil")
                    return
                }
                rover = marsRover
                fetchRoverExpectation.fulfill()
            }

            wait(for: [fetchRoverExpectation], timeout: 5)

            // Getting photos from the rover
            let fetchPhotoExpectation = self.expectation(description: "Wait for completion of photo collection")
            let mockPhotoDataTask = MockLoader(data: validSol1JSON, error: nil)
            marsRoverClient = MarsRoverClient(networkLoader: mockPhotoDataTask)

            marsRoverClient.fetchPhotos(from: rover!, onSol: 1) { (marsPhotoReference, error) in
                XCTAssertNil(error, "Expected error = nil, but got error: \(error!)")
                guard let photoRefs = marsPhotoReference else {
                    XCTFail("Mars Rover photos array unexpectedly equals nil.")
                    return
                }
                XCTAssertGreaterThan(photoRefs.count, 0)
                XCTAssertEqual(photoRefs.first?.id, 4477)
                XCTAssertEqual(photoRefs.first?.imageURL.absoluteString, "http://mars.jpl.nasa.gov/msl-raw-images/msss/00001/mcam/0001ML0000001000I1_DXXX.jpg")

                fetchPhotoExpectation.fulfill()
            }

            wait(for: [fetchPhotoExpectation], timeout: 5)
        }


    }

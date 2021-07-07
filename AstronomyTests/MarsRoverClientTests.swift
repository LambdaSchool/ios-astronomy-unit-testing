//
//  AstronomyMarsRoverClientTests.swift
//  AstronomyTests
//
//  Created by Marlon Raskin on 9/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
import XCTest
@testable import Astronomy

class MarsRoverClientTests: XCTestCase {
	
	func testMarsRoverClient() {
		let marsRoverClient = MarsRoverClient()
		let didFinishFetchingRover = self.expectation(description: "Finished fetching rover")
		marsRoverClient.fetchMarsRover(named: "curiosity") { (rover, error) in
			didFinishFetchingRover.fulfill()
			if let rover = rover {
				XCTAssertTrue(rover.status.rawValue == "active")
			}
		}
		wait(for: [didFinishFetchingRover], timeout: 5)
	}


	func testFetchResultsForGoodRoverData() {
		let mock = MockDataLoader()
		mock.data = validRoverJSON
		let marsRoverClient = MarsRoverClient(networkLoader: mock)
		let completionExpectation = expectation(description: "Async completion")
		var newRover: MarsRover?

		marsRoverClient.fetchMarsRover(named: "curiosity") { (resultRover, error) in
			newRover = resultRover
			completionExpectation.fulfill()
		}

		waitForExpectations(timeout: 5)
		XCTAssertEqual(10, newRover?.maxSol)
		XCTAssertEqual(4156, newRover?.numberOfPhotos)
	}
	

	func testFetchResultsForGoodSolData() {
		let mock = MockDataLoader()
		mock.data = validRoverJSON
		let marsRoverClient = MarsRoverClient(networkLoader: mock)
		let roverCompletionExpectation = expectation(description: "Rover async Completion")
		let referenceCompletionExpectation = expectation(description: "Reference async completion")
		var newRover: MarsRover?


		marsRoverClient.fetchMarsRover(named: "curiosity") { (resultRover, error) in
			newRover = resultRover
			roverCompletionExpectation.fulfill()
		}
		wait(for: [roverCompletionExpectation], timeout: 5)

		guard let rover = newRover else { return }
		mock.data = validSol1JSON
		var photoReference: MarsPhotoReference?

		marsRoverClient.fetchPhotos(from: rover, onSol: 1) { (marsPhotoReferences, error) in
			referenceCompletionExpectation.fulfill()
			guard let reference = marsPhotoReferences?.first else { return }
			photoReference = reference
		}

		wait(for: [referenceCompletionExpectation], timeout: 5)
		XCTAssertEqual(4477, photoReference?.id)
		XCTAssertEqual("MAST", photoReference?.camera.name)
		XCTAssertEqual("Mast Camera", photoReference?.camera.fullName)
	}

	func testBadKeyForFetchMarsRoverFunction() {
		let mock = MockDataLoader()
		mock.data = invalidRoverJSON
		let marsRoverClient = MarsRoverClient(networkLoader: mock)
		let roverCompletionExpectation = expectation(description: "Rover async Completion")

		marsRoverClient.fetchMarsRover(named: "curiosity") { (rover, error) in
			XCTAssertEqual(nil, rover?.maxSol, "Invalid key for dictionary")
			roverCompletionExpectation.fulfill()
		}
		waitForExpectations(timeout: 5, handler: nil)
	}

	func testBadKeyForFetchPhotosFunction() {
		let mock = MockDataLoader()
		mock.data = validRoverJSON
		let marsRoverClient = MarsRoverClient(networkLoader: mock)
		let roverCompletionExpectation = expectation(description: "Rover async Completion")
		let referenceCompletionExpectation = expectation(description: "Reference async completion")
		var newRover: MarsRover?


		marsRoverClient.fetchMarsRover(named: "curiosity") { (resultRover, error) in
			newRover = resultRover
			roverCompletionExpectation.fulfill()
		}

		wait(for: [roverCompletionExpectation], timeout: 5)

		guard let rover = newRover else { return }
		mock.data = invalidSol1JSON
		var photoReference: MarsPhotoReference?
//		var resultError: Error?

		marsRoverClient.fetchPhotos(from: rover, onSol: 1) { (marsPhotoReferences, error) in
			referenceCompletionExpectation.fulfill()
//			guard let reference = marsPhotoReferences?.first else { return }
			photoReference = marsPhotoReferences?.first
			XCTAssertEqual(photoReference, marsPhotoReferences?.first, "Fetching photos from data failed")
		}

		wait(for: [referenceCompletionExpectation], timeout: 5)
	}
}

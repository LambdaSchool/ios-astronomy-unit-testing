//
//  MarsRoverClientTests.swift
//  AstronomyTests
//
//  Created by Julian A. Fordyce on 3/8/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import XCTest
@testable import Astronomy

class MockLoader: NetworkDataLoader {
    
    var request: URLRequest?
    var data: Data?
    var error: Error?

    func loadData(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        self.request = request
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

    func testFetchMarsRover() {
        
    }

    func testFetchPhotos() {
        
    }

}

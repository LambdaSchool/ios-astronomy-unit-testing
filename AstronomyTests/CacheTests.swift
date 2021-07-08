//
//  CacheTests.swift
//  AstronomyTests
//
//  Created by Dillon McElhinney on 10/22/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import XCTest
@testable import Astronomy

class CacheTests: XCTestCase {
    
    var cache = Cache<Int, String>()
    
    override func setUp() {
        cache = Cache<Int, String>()
        cache.cache(value: "String 1", for: 1)
        cache.cache(value: "String 2", for: 2)
    }

    func testStoringValueInCache() {
        XCTAssertNil(cache.value(for: 3))
        cache.cache(value: "String 3", for: 3)
        XCTAssertEqual(cache.value(for: 3), "String 3")
        cache.cache(value: "Updated String 1", for: 1)
        XCTAssertEqual(cache.value(for: 1), "Updated String 1")
    }
    
    func testRetrievingValueFromCache() {
        XCTAssertEqual(cache.value(for: 1), "String 1")
        XCTAssertEqual(cache.value(for: 2), "String 2")
    }
    
    func testClearingCache() {
        XCTAssertNotNil(cache.value(for: 1))
        XCTAssertNotNil(cache.value(for: 2))
        cache.clear()
        XCTAssertNil(cache.value(for: 1))
        XCTAssertNil(cache.value(for: 2))
    }

}

//
//  MockDataLoader.swift
//  AstronomyTests
//
//  Created by Marlon Raskin on 9/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
@testable import Astronomy

class MockDataLoader: NetworkDataLoader {
	var data: Data?
	var error: Error?

	func loadData(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
		DispatchQueue.global().async {
			completion(self.data, self.error)
		}
	}

	func loadData(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
		DispatchQueue.global().async {
			completion(self.data, self.error)
		}
	}
}

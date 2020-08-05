//
//  MockLoader.swift
//  AstronomyTests
//
//  Created by Clayton Watkins on 8/5/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
@testable import Astronomy

struct MockLoader: NetworkDataLoader {
    
    // MARK: - Properties
    var data: Data?
    var error: Error?
    
    
    // MARK: - Protocol Conformance
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

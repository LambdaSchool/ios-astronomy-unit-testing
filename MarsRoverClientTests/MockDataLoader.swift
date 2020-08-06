//
//  MockDataLoader.swift
//  Astronomy
//
//  Created by Mark Gerrior on 4/20/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
@testable import Astronomy

class MockDataLoader: NetworkDataLoader {
    let data: Data?
    let error: Error?
    
    internal init(data: Data?, error: Error?) {
        self.data = data
        self.error = error
    }
    
    func loadData(from reqeust: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        // User a timer so you can cancel it. But this is cool for now.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.005 /* ms */) {
            completion(self.data, self.error)
        }
    }
    
    func loadData(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
        // User a timer so you can cancel it. But this is cool for now.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.005 /* ms */) {
            completion(self.data, self.error)
        }
    }
    
}

//
//  MockLoader.swift
//  AstronomyTests
//
//  Created by Stephanie Ballard on 6/15/20.
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
    
    //TODO: Implement the two loadData() functions. They should call the passed completion closure with the values of object's data and error properties. Make them call the completion closure asynchronously on the global background queue.
    
    func loadData(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.005) {
            completion(self.data, self.error)
        }
    }
    
    func loadData(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.005) {
            completion(self.data, self.error)
        }
    }
}

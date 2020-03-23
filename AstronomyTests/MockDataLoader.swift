//
//  MockDataLoader.swift
//  AstronomyTests
//
//  Created by Tobi Kuyoro on 23/03/2020.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
@ testable import Astronomy

class MockDataLoader: NetworkDataLoader {
   let data: Data?
   let response: URLResponse?
   let error: Error?
   
   internal init(data: Data?, response: URLResponse?, error: Error?) {
      self.data = data
      self.response = response
      self.error = error
   }
   
   func loadData(from request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
      completion(self.data, self.response, self.error)
   }
   
   func loadData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
      completion(self.data, self.response, self.error)
   }
}

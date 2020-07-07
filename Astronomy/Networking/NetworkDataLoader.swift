//
//  NetworkDataLoader.swift
//  Astronomy
//
//  Created by Chad Parker on 6/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

protocol NetworkDataLoader {
   func loadData(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void)
   func loadData(from url: URL, completion: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkDataLoader {
   func loadData(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
      let dataTask = self.dataTask(with: request) { data, _, error in
         completion(data, error)
      }
      dataTask.resume()
   }
   
   func loadData(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
      let dataTask = self.dataTask(with: url) { data, _, error in
         completion(data, error)
      }
      dataTask.resume()
   }
}

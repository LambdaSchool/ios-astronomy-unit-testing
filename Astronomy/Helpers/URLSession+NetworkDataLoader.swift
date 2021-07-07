//
//  URLSession+NetworkDataLoader.swift
//  Astronomy
//
//  Created by Lambda_School_Loaner_268 on 3/23/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

extension URLSession: NetworkDataLoader {
    
    func loadData(using request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        self.dataTask(with: request) { (data, response, error) in
            completion(data, error)
        }.resume()
    }
    
    func loadData(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
        self.dataTask(with: url) { (data, response, error) in
            completion(data, error)
        }.resume()
    }
}

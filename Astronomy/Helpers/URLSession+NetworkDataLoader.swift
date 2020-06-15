//
//  URLSession+NetworkDataLoader.swift
//  Astronomy
//
//  Created by Nonye on 6/15/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation


extension URLSession: NetworkDataLoader {
    func loadData(using request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        dataTask(with: request) { data, _, error in
            completion(data, error)
        }.resume()
    }
}
    

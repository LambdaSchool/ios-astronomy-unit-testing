//
//  NetworkDataLoader.swift
//  Astronomy
//
//  Created by Paul Yi on 3/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol NetworkDataLoader {
    
    func loadData(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkDataLoader {
    func loadData(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        
        dataTask(with: request) { (data, _, error) in
            completion(data, error)
        }.resume()
    }
    

}

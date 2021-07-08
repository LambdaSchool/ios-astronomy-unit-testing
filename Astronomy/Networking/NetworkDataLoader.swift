//
//  NetworkDataLoader.swift
//  Astronomy
//
//  Created by Dillon McElhinney on 10/22/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

protocol NetworkDataLoader {
    func loadData(using request: URLRequest, completion: @escaping (Data?, Error?) -> Void)
    func loadData(using url: URL, completion: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkDataLoader {
    func loadData(using request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        dataTask(with: request, completionHandler: { (data, _, error) in
            completion(data, error)
        }).resume()
    }
    
    func loadData(using url: URL, completion: @escaping (Data?, Error?) -> Void) {
        dataTask(with: url) { (data, _, error) in
            completion(data, error)
        }.resume()
    }
}

//
//  URLSession+NetworkDataLoader.swift
//  Astronomy
//
//  Created by Mitchell Budge on 6/24/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

extension URLSession: NetworkDataLoader {
    
    func loadData(from request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
    }
    
    func loadData(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
        
    }
    
}

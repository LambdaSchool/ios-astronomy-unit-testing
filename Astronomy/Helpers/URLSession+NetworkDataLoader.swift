//
//  URLSession+NetworkDataLoader.swift
//  Astronomy
//
//  Created by Ciara Beitel on 10/14/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

extension URLSession: NetworkDataLoader {
    func loadData(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        <#code#>
    }
    
    func loadData(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
        <#code#>
    }
    
    
}

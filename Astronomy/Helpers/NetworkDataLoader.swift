//
//  NetworkDataLoader.swift
//  Astronomy
//
//  Created by BrysonSaclausa on 9/30/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

protocol NetworkDataLoader {
   
    func loadData(with request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
    
    
}

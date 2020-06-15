//
//  NetworkDataLoader.swift
//  MarsRoverTests
//
//  Created by Nonye on 6/15/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

protocol NetworkDataLoader {
    func loadData(using request: URLRequest, completion: @escaping (Data?, Error?) -> Void)
}


//
//  NetworkDataLoader.swift
//  Astronomy
//
//  Created by Jeffrey Santana on 9/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol NetworkDataLoader {
	func loadData(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void)
	
	func loadData(from request: URL, completion: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkDataLoader {
	func loadData(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
		dataTask(with: request) { (data, _, error) in
			completion(data, error)
		}.resume()
	}
	
	func loadData(from request: URL, completion: @escaping (Data?, Error?) -> Void) {
		dataTask(with: request) { (data, _, error) in
			completion(data, error)
		}.resume()
	}
}

//
//  Camera.swift
//  Astronomy
//
//  Created by Andrew R Madsen on 9/5/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

struct Camera: Codable, Equatable {
    let id: Int
    let name: String
    let rover_id: Int
    let full_name: String
}

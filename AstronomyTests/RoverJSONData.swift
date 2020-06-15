//
//  RoverJSONData.swift
//  AstronomyTests
//
//  Created by Enzo Jimenez-Soto on 6/15/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

let validRoverJSON = """
{
    "photo_manifest": {
        "name": "Curiosity",
        "landing_date": "2012-08-06",
        "launch_date": "2011-11-26",
        "status": "active",
        "max_sol": 10,
        "max_date": "2012-08-16",
        "total_photos": 4156,
        "photos": [{
                "sol": 0,
                "earth_date": "2012-08-06",
                "total_photos": 3702,
                "cameras": [
                    "CHEMCAM",
                    "FHAZ",
                    "MARDI",
                    "RHAZ"
                ]
            },
            {
                "sol": 1,
                "earth_date": "2012-08-07",
                "total_photos": 16,
                "cameras": [
                    "MAHLI",
                    "MAST",
                    "NAVCAM"
                ]
            },
            {
                "sol": 2,
                "earth_date": "2012-08-08",
                "total_photos": 74,
                "cameras": [
                    "NAVCAM"
                ]
            },
            {
                "sol": 3,
                "earth_date": "2012-08-09",
                "total_photos": 338,
                "cameras": [
                    "MAST"
                ]
            },
            {
                "sol": 10,
                "earth_date": "2012-08-16",
                "total_photos": 26,
                "cameras": [
                    "CHEMCAM",
                    "MAHLI",
                    "NAVCAM"
                ]
            }
        ]
    }
}
""".data(using: .utf8)

let invalidRoverJSON = """
{
    "photo_manifest": {
        "name": "Curiosity",
        "landing_date": "2012-08-06",
        "launch_date": "2011-11-26",
        "status": "active",
        "max_sol": 10,
        "max_date": "2012-08-16",
        "total_photos": 4156,
        "photos": [{
                "sol": 0,
                "earth_date": "2012-08-06",
                "total_photos": 3702,
                "cameras": [
                    "CHEMCAM",
                    "FHAZ",
                    "MARDI",
                    "RHAZ"
                ]
            },
            {
                "sol": 1,
                "earth_date": "2012-08-07",
                "total_photos": 16,
                "cameras": [
                    "MAHLI",
                    "MAST",
                    "NAVCAM"
                ]
            },
            {
                "sol": 2,
                "earth_date": "2012-08-08",
                "total_photos": 74,
                "cameras": [
                    "NAVCAM"
                ]
            },
            {
                "sol": 3,
                "earth_date": "2012-08-09",
                "total_photos": 338,
                "cameras": [
                    "MAST"
                ]
            },
            {
                "sol": 10,
                "earth_date": "2012-08-16",
                "total_photos": 26,
                "cameras": [
                    "CHEMCAM",
                    "MAHLI",
                    "NAVCAM"
                ]
            }
        ]
    }

""".data(using: .utf8)

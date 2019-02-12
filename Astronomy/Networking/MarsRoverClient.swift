//
//  MarsRoverClient.swift
//  Astronomy
//
//  Created by Andrew R Madsen on 9/5/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class MarsRoverClient {
    
    init(networkLoader: NetworkDataLoader = URLSession.shared){
        self.networkLoader = networkLoader
    }
    
    func getURLforRover(forInfoForRover roverName: String) -> URL {
        return url(forInfoForRover: roverName)
    }
    
    func getURLforPhoto(forPhotosfromRover roverName: String, on sol: Int) -> URL {
        return url(forPhotosfromRover: roverName, on: sol)
    }
    
    func fetchMarsRover(named name: String,
                        completion: @escaping (MarsRover?, Error?) -> Void) {
        
        let url = self.url(forInfoForRover: name)
        fetch(from: url) { (dictionary: [String : MarsRover]?, error: Error?) in

            guard let rover = dictionary?["photoManifest"] else {
                self.roverError = error
                completion(nil, error)
                return
            }
            completion(rover, nil)
        }
    }
    
    func fetchPhotos(from rover: MarsRover,
                     onSol sol: Int,
                     completion: @escaping ([MarsPhotoReference]?, Error?) -> Void) {
        
        let url = self.url(forPhotosfromRover: rover.name, on: sol)
        fetch(from: url) { (dictionary: [String : [MarsPhotoReference]]?, error: Error?) in
            guard let photos = dictionary?["photos"] else {
                self.photosError = error
                completion(nil, error)
                return
            }
            completion(photos, nil)
        }
    }
    
    // MARK: - Private
    
    private func fetch<T: Codable>(from url: URL, completion: @escaping (T?, Error?) -> Void) {
        networkLoader.loadData(from: url) { (data, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "com.LambdaSchool.Astronomy.ErrorDomain", code: -1, userInfo: nil))
                return
            }
            
            do {
                let jsonDecoder = MarsPhotoReference.jsonDecoder
                let decodedObject = try jsonDecoder.decode(T.self, from: data)
                completion(decodedObject, nil)
            } catch {
                completion(nil, error)
            }
        }
    }
    
    private let baseURL = URL(string: "https://api.nasa.gov/mars-photos/api/v1")!
    private let apiKey = "qzGsj0zsKk6CA9JZP1UjAbpQHabBfaPg2M5dGMB7"

    private func url(forInfoForRover roverName: String) -> URL {
        var url = baseURL
        url.appendPathComponent("manifests")
        url.appendPathComponent(roverName)
        let urlComponents = NSURLComponents(url: url, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        return urlComponents.url!
    }
    
    private func url(forPhotosfromRover roverName: String, on sol: Int) -> URL {
        var url = baseURL
        url.appendPathComponent("rovers")
        url.appendPathComponent(roverName)
        url.appendPathComponent("photos")
        let urlComponents = NSURLComponents(url: url, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = [URLQueryItem(name: "sol", value: String(sol)),
                                    URLQueryItem(name: "api_key", value: apiKey)]
        return urlComponents.url!
    }
    
    let networkLoader: NetworkDataLoader
    var rover: MarsRover? = nil
    var photos: [MarsPhotoReference]? = nil
    var roverError: Error? = nil
    var photosError: Error? = nil
}

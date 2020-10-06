//
//  PhotoInfoController.swift
//  SpacePhoto
//
//  Created by Joseph on 07/05/2020.
//  Copyright © 2020 Joseph Doogan. All rights reserved.
//

import Foundation

class PhotoInfoController {
    
    // Create a networking function which can be called repeatedly
    func fetchPhotoInfo(matching query: [String: String], completion: @escaping (PhotoInfo?) -> Void) {
        
        // Create a URL object with the base URL for NASA's APOD API
        let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
        
        // Create a URL object that uses the base URL with query parameters based on query dictionary
        let url = baseURL.withQueries(query)!

        // Create a URLSessionDataTask object from the shared URLSession
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Create a  JSONDecoder object
            let jsonDecoder = JSONDecoder()
            
            // Unwrap the data if not nil, and attempt to decode the JSON data into a PhotoInfo object
            if let data = data,
                let photoInfo = try? jsonDecoder.decode(PhotoInfo.self, from: data) {
                
                // Pass the PhotoInfo object to the completion closure
                completion(photoInfo)
                
            } else {
                
                // Print an error message to the console
                print("Either no data was returned, or data was not properly decoded.")
                
                // Pass 'nil' to the completion closure
                completion(nil)
            }
        }

        // Send the request by resuming the task
        task.resume()
    }
}

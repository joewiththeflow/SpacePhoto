//
//  URL+Helpers.swift
//  SpacePhoto
//
//  Created by Joseph on 07/05/2020.
//  Copyright © 2020 Joseph Doogan. All rights reserved.
//

import Foundation

// Add an extension to the URL type
extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        
        // Initialise URLComponets instance based on current URL
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        
        // Map the queries dictionary to URLQueryItem instances, and adds these QueryItem instances to the queryItems property of the URL
        components?.queryItems = queries.map { URLQueryItem(name: $0.0, value: $0.1)}
        
        // Return the URL with query parameters added
        return components?.url
    }
}

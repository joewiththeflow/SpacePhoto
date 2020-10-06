//
//  PhotoInfo.swift
//  SpacePhoto
//
//  Created by Joseph on 07/05/2020.
//  Copyright © 2020 Joseph Doogan. All rights reserved.
//

import Foundation

// Create a custom PhotoInfo struct
struct PhotoInfo: Codable {
    var title: String
    var description: String
    var url: URL
    var copyright: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description = "explanation"
        case url
        case copyright
    }
    
    init(from decoder: Decoder) throws {
        // Access a KeyedCodingContainer that contains key/value pairs associated with the 'cases' in CodingKeys
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        // Get each of the values corresponding to the keys you wish to use, and assign them to the correct properties
        self.title = try valueContainer.decode(String.self, forKey: CodingKeys.title)
        self.description = try valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.url = try valueContainer.decode(URL.self, forKey: CodingKeys.url)
        self.copyright = try? valueContainer.decode(String.self, forKey: CodingKeys.copyright)
    }
}

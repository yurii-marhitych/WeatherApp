//
//  RandomImage.swift
//  WeatherApp
//
//  Created by Yurii Marhitych on 28.04.2022.
//

import Foundation

struct RandomImage {
    
    // MARK: - Properties
    let url: URL
}

// MARK: - Decodable
extension RandomImage: Decodable {
    
    // MARK: - Initializer
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let stringURL = try container.decode(String.self, forKey: .url)
        
        guard let url = URL(string: stringURL) else {
            throw NSError(domain: "random.cat", code: 1, userInfo: nil)
        }
        
        self.init(url: url)
    }
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case url = "file"
    }
}

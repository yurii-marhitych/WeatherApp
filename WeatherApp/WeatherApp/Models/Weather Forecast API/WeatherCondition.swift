//
//  WeatherCondition.swift
//  WeatherApp
//
//  Created by Yurii Marhitych on 28.04.2022.
//

struct WeatherCondition {
    
    // MARK: - Properties
    let title: String
    let subtitle: String
    let icon: String
    
    // MARK: - Initializer
    init() {
        title = "Clear"
        subtitle = "clear sky"
        icon = "01d"
    }
}

// MARK: - Decodable
extension WeatherCondition: Decodable {
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case title = "main"
        case subtitle = "description"
        case icon
    }
}

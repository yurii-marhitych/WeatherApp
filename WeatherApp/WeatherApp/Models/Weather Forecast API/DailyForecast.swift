//
//  DailyForecast.swift
//  WeatherApp
//
//  Created by Yurii Marhitych on 28.04.2022.
//

import Foundation

struct DailyForecast {
    
    // MARK: - Properties
    let date: Date?
    let minTemperature: Double
    let maxTemperature: Double
    let conditionIcon: String
}

// MARK: - Decodable
extension DailyForecast: Decodable {
    
    // MARK: - Initializer
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let dateUnix = try container.decode(Double.self, forKey: .date)
        let date = Date(unixTime: dateUnix)
        
        let temperatureContainer = try container.nestedContainer(keyedBy: TemperatureCodingKeys.self, forKey: .temperature)
        let minTemperature = try temperatureContainer.decode(Double.self, forKey: .minTemperature)
        let maxTemperature = try temperatureContainer.decode(Double.self, forKey: .maxTemperature)
        
        let weatherCondition = try container.decode([WeatherCondition].self, forKey: .conditionIcon)
        
        self.init(date: date,
                  minTemperature: minTemperature,
                  maxTemperature: maxTemperature,
                  conditionIcon: (weatherCondition.first ?? WeatherCondition()).icon)
    }
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case temperature = "temp"
        case conditionIcon = "weather"
    }
    
    enum TemperatureCodingKeys: String, CodingKey {
        case minTemperature = "min"
        case maxTemperature = "max"
    }
}

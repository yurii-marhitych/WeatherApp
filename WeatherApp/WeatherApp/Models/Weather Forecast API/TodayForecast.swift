//
//  TodayForecast.swift
//  WeatherApp
//
//  Created by Yurii Marhitych on 28.04.2022.
//

import Foundation

struct TodayForecast {
    
    // MARK: - Properties
    let sunrise: Date?
    let sunset: Date?
    let temperature: Double
    let feelsTemperature: Double
    let pressure: Int
    let humidity: Int
    let visibility: Int
    let windSpeed: Double
    let condition: WeatherCondition
}

// MARK: - Decodable
extension TodayForecast: Decodable {
    
    // MARK: - Initializer
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let sunriseUnix = try container.decode(Double.self, forKey: .sunrise)
        let sunsetUnix = try container.decode(Double.self, forKey: .sunset)
        let temperature = try container.decode(Double.self, forKey: .temperature)
        let feelsTemperature = try container.decode(Double.self, forKey: .feelsTemperature)
        let pressure = try container.decode(Int.self, forKey: .pressure)
        let humidity = try container.decode(Int.self, forKey: .humidity)
        let visibility = try container.decode(Int.self, forKey: .visibility)
        let windSpeed = try container.decode(Double.self, forKey: .windSpeed)
        let weatherCondition = try container.decode([WeatherCondition].self, forKey: .condition)
        
        let sunrise = Date(unixTime: sunriseUnix)
        let sunset = Date(unixTime: sunsetUnix)
        
        self.init(sunrise: sunrise,
                  sunset: sunset,
                  temperature: temperature,
                  feelsTemperature: feelsTemperature,
                  pressure: pressure, humidity: humidity,
                  visibility: visibility,
                  windSpeed: windSpeed,
                  condition: weatherCondition.first ?? WeatherCondition())
    }
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case sunrise
        case sunset
        case temperature = "temp"
        case feelsTemperature = "feels_like"
        case pressure
        case humidity
        case visibility
        case windSpeed = "wind_speed"
        case condition = "weather"
    }
}




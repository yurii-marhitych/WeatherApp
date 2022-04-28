//
//  WeatherForecast.swift
//  WeatherApp
//
//  Created by Yurii Marhitych on 28.04.2022.
//

struct WeatherForecast {
    
    // MARK: - Properties
    let todayForecast: TodayForecast
    let dailyForecastList: [DailyForecast]
}

// MARK: - Decodable
extension WeatherForecast: Decodable {
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case todayForecast = "current"
        case dailyForecastList = "daily"
    }
}

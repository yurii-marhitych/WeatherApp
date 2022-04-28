//
//  WeatherForecastTableViewCellViewModel.swift
//  WeatherApp
//
//  Created by Yurii Marhitych on 28.04.2022.
//

import UIKit

struct WeatherForecastTableViewCellViewModel {
    
    // MARK: - Properties
    private let todayForecast: TodayForecast
    private let city: String
    
    var cityName: String {
        return city.capitalized
    }

    var temperature: String {
        return format(temperature: todayForecast.temperature)
    }
    
    var maxTemperature: String {
        return "B:" + format(temperature: todayForecast.temperature)
    }
    
    var minTemperature: String {
        return "H:" + format(temperature: todayForecast.temperature)
    }
    
    var description: String {
        return todayForecast.condition.subtitle
    }
    
    // MARK: - Init
    init(forecast: TodayForecast, city: String) {
        self.todayForecast = forecast
        self.city = city
    }
}

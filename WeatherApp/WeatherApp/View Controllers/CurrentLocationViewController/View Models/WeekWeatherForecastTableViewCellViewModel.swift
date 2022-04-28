//
//  WeekWeatherForecastTableViewCellViewModel.swift
//  WeatherApp
//
//  Created by Yurii Marhitych on 28.04.2022.
//

import UIKit

class WeekWeatherForecastTableViewCellViewModel {
    
    // MARK: - Properties
    private let dailyForecast: DailyForecast
    private var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dddd-MM"
        dateFormatter.timeZone = .current
        return dateFormatter
    }()
    
    var date: String {
        if let date = dailyForecast.date {
            return dateFormatter.string(from: date)
        }
        
        return ""
    }
    
    var minTemperature: String {
        return format(temperature: dailyForecast.minTemperature)
    }
    
    var maxTemperature: String {
        return format(temperature: dailyForecast.maxTemperature)
    }
    
    var icon: UIImage {
        // TODO: Load from API
        return UIImage(systemName: "cloud")!
    }
    
    // MARK: - Initializer
    init(dailiForecast: DailyForecast) {
        self.dailyForecast = dailiForecast
    }
}

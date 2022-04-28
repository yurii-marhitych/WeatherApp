//
//  WeatherForecastTableViewCellViewModel.swift
//  WeatherApp
//
//  Created by Yurii Marhitych on 28.04.2022.
//

struct WeatherForecastTableViewCellViewModel {
    
    // MARK: - Properties
    let todayForecast: TodayForecast
    let city: String
    
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
    
    // MARK: - Helper Methods
    private func format(temperature: Double) -> String {
        return String(format: "%.1f°", temperature)
    }
}

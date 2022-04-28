//
//  WeatherViewViewModel.swift
//  WeatherApp
//
//  Created by Yurii Marhitych on 28.04.2022.
//

import Combine

class WeatherViewViewModel {
    
    // MARK: - Properties
    private var subscriptions = Set<AnyCancellable>()
    
    private let weatherForecastManager = WeatherForecastManager()
    let weatherForecasts = CurrentValueSubject<[WeatherForecast], Never>([])
    let cities = CurrentValueSubject<[String], Never>([])
    private(set) var errorMessage = PassthroughSubject<String, Never>()
    
    var numberOfRows: Int {
        return weatherForecasts.value.count
    }
    
    // MARK: - Methods
    func fetchWeatherForecast(for city: String) {
        weatherForecastManager
            .fetchWeatherForecast(forCity: city)
            .sink { completion in
                if case let .failure(error) = completion {
                    let message: String
                    switch error {
                    case .badURL:
                        message = "Could not get access to OpenWeatherMap API."
                    case .fetching:
                        message = "Could not fetch weather forecast from dowbloaded data."
                    }
                    
                    self.errorMessage.send(message)
                }
            } receiveValue: { weatherForecast in
                self.weatherForecasts.value.append(weatherForecast)
                self.cities.value.append(city)
            }
            .store(in: &subscriptions)
    }
    
    func getViewModelForTableViewCell(at index: Int) -> WeatherForecastTableViewCellViewModel {
        let weatherForecast = weatherForecasts.value[index]
        let city = cities.value[index]
        return WeatherForecastTableViewCellViewModel(todayForecast: weatherForecast.todayForecast, city: city)
    }
}

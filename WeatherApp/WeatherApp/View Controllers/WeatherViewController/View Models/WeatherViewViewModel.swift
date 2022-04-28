//
//  WeatherViewViewModel.swift
//  WeatherApp
//
//  Created by Yurii Marhitych on 28.04.2022.
//

import Combine
import UIKit

class WeatherViewViewModel {
    
    // MARK: - Properties
    private var subscriptions = Set<AnyCancellable>()
    private let keyForUserDefaults = "cities"
    
    /// Managers
    private let weatherForecastManager = WeatherForecastManager()
    private let randomImageManager = RandomImageManager()
    
    let weatherForecasts = CurrentValueSubject<[WeatherForecast], Never>([])
    private let cities = CurrentValueSubject<[String], Never>([])
    let errorMessage = PassthroughSubject<String, Never>()
    @Published var randomImage: UIImage?
    
    var numberOfRows: Int {
        return weatherForecasts.value.count
    }
    
    // MARK: - Methods
    func fetchWeatherForecast(for city: String) {
        
        if cities.value.contains(city) {
            errorMessage.send("Weather forecast for this city already exists!")
            return
        }
        
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
    
    func fetchRandomImage() {
        randomImageManager
            .fetchRandomImage()
            .sink { completion in
                if case let .failure(error) = completion {
                    let message: String
                    switch error {
                    case .badURL:
                        message = "Could not get access to random.cat API."
                    case .badAPIResponse:
                        message = "Could not to get data from random.cat API."
                    case .fetchingImage:
                        message = "Could not convert parsed data into image."
                    }
                    
                    self.errorMessage.send(message)
                }
            } receiveValue: { image in
                self.randomImage = image
            }
            .store(in: &subscriptions)
    }
    
    func getViewModelForTableViewCell(at index: Int) -> WeatherForecastTableViewCellViewModel {
        let weatherForecast = weatherForecasts.value[index]
        let city = cities.value[index]
        return WeatherForecastTableViewCellViewModel(forecast: weatherForecast.todayForecast, city: city)
    }

    func saveCities() {
        let cities = self.cities.value
        UserDefaults.standard.set(cities, forKey: keyForUserDefaults)
    }
    
    func loadSavedCities() {
        guard let cities = UserDefaults.standard.object(forKey: keyForUserDefaults) as? [String] else  { return }
        cities.forEach { fetchWeatherForecast(for: $0) }
    }
}

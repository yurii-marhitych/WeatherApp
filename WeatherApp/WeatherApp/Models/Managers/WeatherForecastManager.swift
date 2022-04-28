//
//  WeatherForecastManager.swift
//  WeatherApp
//
//  Created by Yurii Marhitych on 28.04.2022.
//

import Combine
import CoreLocation
import Foundation

class WeatherForecastManager {
    
    // MARK: - Error Type
    enum ForecastError: Error {
        case fetching
        case badURL
    }
    
    // MARK: - Properties
    private let apiKey = "&appid=b1ce922dc454c7f5302c640ab1a3727a"
    private let baseURL = "https://api.openweathermap.org/data/2.5/onecall?"
    private var units: String {
        return "&units=metric"
    }
    private let supportParams = "&exclude=minutely,hourly"
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Methods
    func fetchWeatherForecast(forCity city: String) -> Future<WeatherForecast, ForecastError> {
        
        return Future { promise in
            let geocoder = CLGeocoder()
            
            geocoder.geocodeAddressString(city) { [self] placemarks, error in
                
                if let coordinate = placemarks?.first?.location?.coordinate,
                   let url = URL(string: baseURL + "&lat=\(coordinate.latitude)&lon=\(coordinate.longitude)" + supportParams + units + apiKey) {
                    
                    URLSession.shared
                        .dataTaskPublisher(for: url)
                        .map(\.data)
                        .decode(type: WeatherForecast.self, decoder: JSONDecoder())
                        .sink { completion in
                            if case .failure = completion {
                                promise(.failure(.fetching))
                            }
                        } receiveValue: { weatherForecast in
                            promise(.success(weatherForecast))
                        }
                        .store(in: &subscriptions)
                } else {
                    promise(.failure(.badURL))
                }
            }
        }
    }
}

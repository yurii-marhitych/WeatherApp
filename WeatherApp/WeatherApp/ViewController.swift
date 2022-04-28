//
//  ViewController.swift
//  WeatherApp
//
//  Created by Yurii Marhitych on 27.04.2022.
//

import UIKit
import Combine

class ViewController: UIViewController {

    // MARK: - Properties
    private var subscriptions = Set<AnyCancellable>()
    let manager = WeatherForecastManager()
    
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.fetchWeatherForecast(forCity: "Kyiv")
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("Completed with: \(completion)")
            } receiveValue: { weatherForecast in
                debugPrint(weatherForecast.dailyForecastList)
            }
            .store(in: &subscriptions)
    }
}


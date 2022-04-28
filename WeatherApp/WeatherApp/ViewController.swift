//
//  ViewController.swift
//  WeatherApp
//
//  Created by Yurii Marhitych on 27.04.2022.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Properties
    private var subscriptions = Set<AnyCancellable>()
    private let manager = WeatherForecastManager()
    private let randomImageManager = RandomImageManager()
    
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        manager.fetchWeatherForecast(forCity: "Kyiv")
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("Completed with: \(completion)")
            } receiveValue: { weatherForecast in
                debugPrint(weatherForecast.dailyForecastList)
            }
            .store(in: &subscriptions)
         */
        
        randomImageManager
            .fetchRandomImage()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("Completed: \(completion).")
            } receiveValue: { image in
                print("Received image: \(image).")
                self.imageView.image = image
            }
            .store(in: &subscriptions)
    }
}


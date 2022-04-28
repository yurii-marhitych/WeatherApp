//
//  CurrentLocationViewController.swift
//  WeatherApp
//
//  Created by Yurii Marhitych on 28.04.2022.
//

import UIKit
import Combine

class CurrentLocationViewController: UIViewController {

    // MARK: - Properties
    
    
    // MARK: - Outlets
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var weekForecastTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//
//  WeatherForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Yurii Marhitych on 28.04.2022.
//

import UIKit

class WeatherForecastTableViewCell: UITableViewCell {

    // MARK: - Static Properties
    static let identifier = "WeatherCell"
    
    // MARK: - Outlets
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    
    // MARK: - Methods
    func configure(withViewModel viewModel: WeatherForecastTableViewCellViewModel) {
        cityLabel.text = viewModel.cityName
        stateDescriptionLabel.text = viewModel.description
        temperatureLabel.text = viewModel.temperature
        maxTemperatureLabel.text = viewModel.maxTemperature
        minTemperatureLabel.text = viewModel.minTemperature
    }
}

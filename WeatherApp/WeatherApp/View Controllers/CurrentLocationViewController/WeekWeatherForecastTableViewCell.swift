//
//  WeekWeatherForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Yurii Marhitych on 28.04.2022.
//

import UIKit

class WeekWeatherForecastTableViewCell: UITableViewCell {

    // MARK: - Static Properties
    static let identifier = "WeekWeatherForecastTableViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var stateIconImageView: UIImageView!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    
    // MARK: - Methods
    func configure(withViewModel viewModel: WeekWeatherForecastTableViewCellViewModel) {
        dateLabel.text = viewModel.date
        stateIconImageView.image = viewModel.icon
        maxTemperatureLabel.text = viewModel.maxTemperature
        minTemperatureLabel.text = viewModel.minTemperature
    }
}

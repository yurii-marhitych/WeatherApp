//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Yurii Marhitych on 28.04.2022.
//

import UIKit
import Combine

class WeatherViewController: UIViewController {

    // MARK: - Properties
    private let searchController = UISearchController(searchResultsController: nil)
    private var subscriptions = Set<AnyCancellable>()
    private let weatherViewViewModel = WeatherViewViewModel()
    
    // MARK: - Outlets
    @IBOutlet weak var forecastTableView: UITableView!
    @IBOutlet weak var randomCatImageView: UIImageView!
    
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController()
        configureForecastTableView()
        configureAlerts()
        bindImageView()
        weatherViewViewModel.loadSavedCities()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        weatherViewViewModel.saveCities()
    }
    
    // MARK: - Helper Methods
    private func configureForecastTableView() {
        weatherViewViewModel.weatherForecasts
            .receive(on: DispatchQueue.main)
            .sink { _ in self.forecastTableView.reloadData()}
            .store(in: &subscriptions)
    }
    
    private func configureSearchController() {
        
        // Configure view
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search city"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        // Binding
        searchController.searchBar.searchTextField
            .textPublisher
            .receive(on: DispatchQueue.main)
            .sink { city in
                if !city.isEmpty {
                    self.weatherViewViewModel.fetchWeatherForecast(for: city)
                    self.weatherViewViewModel.fetchRandomImage()
                }
            }
            .store(in: &subscriptions)
    }
    
    private func bindImageView() {
        weatherViewViewModel.$randomImage
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: randomCatImageView)
            .store(in: &subscriptions)
        
        
        // Make It Rounded
        randomCatImageView.clipsToBounds = true
        randomCatImageView.layer.cornerCurve = .continuous
        randomCatImageView.layer.cornerRadius = randomCatImageView.bounds.height / 2.0
    }
    
    private func configureAlerts() {
        weatherViewViewModel.errorMessage
            .receive(on: DispatchQueue.main)
            .sink { self.showAlert(message: $0) }
            .store(in: &subscriptions)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}



// MARK: - UITableViewDataSource
extension WeatherViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print(weatherViewViewModel.numberOfRows)
        return weatherViewViewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherForecastTableViewCell.identifier, for: indexPath) as? WeatherForecastTableViewCell else {
            fatalError("Could not create table view cell of type WeatherForecastTableViewCell")
        }
        
        let cellViewModel = weatherViewViewModel.getViewModelForTableViewCell(at: indexPath.section)
        cell.configure(withViewModel: cellViewModel)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}

// MARK: - UITableViewDelegate
extension WeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

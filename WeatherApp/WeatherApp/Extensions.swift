//
//  Extensions.swift
//  WeatherApp
//
//  Created by Yurii Marhitych on 28.04.2022.
//

import UIKit
import Combine

// MARK: - Date
extension Date {
    
    // MARK: - Initializer
    init?(unixTime: Double) {
        let date = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        let timezone = TimeZone.current.abbreviation() ?? "CET"
        dateFormatter.timeZone = TimeZone(abbreviation: timezone)
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        let dateStr = dateFormatter.string(from: date)
        
        guard let formattedDate = dateFormatter.date(from: dateStr) else {
            return nil
        }
        self = formattedDate
    }
}

// MARK: - UISearchTextField
extension UISearchTextField {
    
    // MARK: - Properties
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(
                for: UISearchTextField.textDidEndEditingNotification,
                   object: self)
            .map(\.object)
            .map { $0 as! UISearchTextField }
            .map(\.text)
            .replaceNil(with: "")
            .map { $0.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) }
            .eraseToAnyPublisher()
    }
}

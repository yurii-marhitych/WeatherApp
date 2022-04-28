//
//  Extensions.swift
//  WeatherApp
//
//  Created by Yurii Marhitych on 28.04.2022.
//

import Foundation

// MARK: - Date
extension Date {
    
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

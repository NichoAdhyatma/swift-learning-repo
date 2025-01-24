//
//  WeatherModel.swift
//  Clima
//
//  Created by nicho@mac on 23/01/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

struct WeatherModel {
    let city: String
    let conditionId: Int
    let temperature: Double
    
    var temperaturString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud.bolt"
        }
    }
}

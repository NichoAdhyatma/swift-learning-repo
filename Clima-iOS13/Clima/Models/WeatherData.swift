//
//  WeatherData.swift
//  Clima
//
//  Created by nicho@mac on 23/01/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let base: String?
    let id: Int?
    let dt: Int?
    let main: Main?
    let coord: Coord?
    let wind: Wind?
    let sys: Sys?
    let weather: [Weather]?
    let visibility: Int?
    let clouds: Clouds?
    let timezone: Int?
    let cod: Int?
    let name: String?
    let rain: Rain?
    
    struct Main: Decodable {
        let humidity: Int?
        let feelsLike: Double?
        let tempMin: Double?
        let tempMax: Double?
        let temp: Double?
        let pressure: Int?
        let seaLevel: Int?
        let grndLevel: Int?
        
        enum CodingKeys: String, CodingKey {
            case humidity, tempMin = "temp_min", tempMax = "temp_max", temp, pressure
            case feelsLike = "feels_like", seaLevel = "sea_level", grndLevel = "grnd_level"
        }
    }
    
    struct Coord: Decodable {
        let lon: Double?
        let lat: Double?
    }
    
    struct Wind: Decodable {
        let speed: Double?
        let deg: Int?
        let gust: Double?
    }
    
    struct Sys: Decodable {
        let country: String?
        let sunrise: Int?
        let sunset: Int?
    }
    
    struct Weather: Decodable {
        let id: Int?
        let main: String?
        let icon: String?
        let description: String?
    }
    
    struct Clouds: Decodable {
        let all: Int?
    }
    
    struct Rain: Decodable {
        let oneHour: Double?
        
        enum CodingKeys: String, CodingKey {
            case oneHour = "1h"
        }
    }
}

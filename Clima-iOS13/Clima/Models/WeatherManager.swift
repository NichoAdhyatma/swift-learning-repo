//
//  WeatherManager.swift
//  Clima
//
//  Created by nicho@mac on 23/01/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func onSuccessFetchWeather(_ weather: WeatherModel)
    func onErrorFetchWeather(_ error: ApiService.ErrorData)
    func onLoadingFetchWeather(_ isLoading: Bool)
}

extension WeatherManagerDelegate {
    func onErrorFetchWeather(_ error: ApiService.ErrorData) {
        
    }
    
    func onLoadingFetchWeather(_ isLoading: Bool) {
        
    }
}

struct WeatherManager {
    let baseURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=\(openWeatherAPIKey)"
    let api = ApiService()
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeatherByCity(_ city: String) {
        let url = URL(string: "\(baseURL)&q=\(city)")!
        
        fetchWeather(by: url)
    }
    
    func fetchWeatherByCoordinate(_ latitude: Double, _ longitude: Double) {
        let url = URL(string: "\(baseURL)&lat=\(latitude)&lon=\(longitude)")!
        
        fetchWeather(by: url)
    }
    
    func fetchWeather(by url: URL) -> Void {
        delegate?.onLoadingFetchWeather(true)
        
        api.performRequest(
            with: url,
            as: WeatherData.self,
            onSuccess: {
                data in
                
                let weather = WeatherModel(
                    city: data.name ?? "",
                    conditionId: data.weather?.first?.id ?? 0,
                    temperature: data.main?.temp ?? 0
                )
                
                delegate?.onSuccessFetchWeather(weather)
                
                delegate?.onLoadingFetchWeather(false)
            },
            onError: {
                error in
                
                delegate?.onErrorFetchWeather(error)
                
                delegate?.onLoadingFetchWeather(false)
            }
        )
    }
}



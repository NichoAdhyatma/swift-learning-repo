//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

import CoreLocation

class WeatherViewController: UIViewController {
    @IBOutlet weak var conditionImageView: UIImageView!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    var weatherManager = WeatherManager()
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        
        searchTextField.delegate = self
    }
}

//MARK: - UITEXTFIELDDELEGATE

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let cityName = searchTextField.text, !cityName.isEmpty {
            textField.endEditing(true)
            
            return true
        } else {
            textField.placeholder = "Enter city name"
            
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let cityName = textField.text {
            weatherManager.fetchWeatherByCity(cityName)
            
            textField.placeholder = "Search City"
        }
        
        textField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text?.isEmpty ?? true {
            textField.placeholder = "Type something"
            
            return false
        }
        
        return true
    }
}

//MARK: - WEATHERMANAGER

extension WeatherViewController: WeatherManagerDelegate {
    func onSuccessFetchWeather(_ weather: WeatherModel) {
        cityLabel.text = weather.city
        
        temperatureLabel.text = "\(weather.temperaturString)"
        
        conditionImageView.image = UIImage(systemName: weather.conditionName)
    }
    
    func onErrorFetchWeather(_ error: ApiService.ErrorData) {
        self.showErrorAlert(message: error.errorMessage)
    }
    
    func onLoadingFetchWeather(_ isLoading: Bool) {
        if(isLoading){
            self.showLoadingView(message: "Featching weather data...")
        } else {
            self.hideLoadingView()
        }
    }
}

//MARK: - LocacitonDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        locationManager.stopUpdatingLocation()
        
        let lat = location.coordinate.latitude
        
        let lon = location.coordinate.longitude
        
        weatherManager.fetchWeatherByCoordinate(lat, lon)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
}

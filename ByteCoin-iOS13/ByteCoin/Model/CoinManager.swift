//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

/// Delegate protocol for UI updates.
protocol CoinManagerUIUpdateDelegate: AnyObject {
    func onLoading(_ isLoading: Bool)
    func onSuccess(_ response: CoinData)
    func onError(_ error: ApiService.ErrorData)
}

/// The CoinManager handles API requests for coin data.
struct CoinManager: ApiServiceDelegate {
    
    // MARK: - Properties
    
    typealias ResponseType = CoinData
    
    private let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    private let apiService = ApiService()
    weak var uiDelegate: CoinManagerUIUpdateDelegate?
    
    let currencyArray = [
        "AUD", "BRL", "CAD", "CNY", "EUR", "GBP", "HKD", "IDR",
        "ILS", "INR", "JPY", "MXN", "NOK", "NZD", "PLN", "RON",
        "RUB", "SEK", "SGD", "USD", "ZAR"
    ]
    
    // MARK: - Methods
    
    func getCoinPrice(for currency: String) {
        guard let url = URL(string: "\(baseURL)/\(currency)?apiKey=\(marketRateAPIKey)") else {
            uiDelegate?.onError(.invalidURL)
            return
        }
        apiService.performRequest(with: url, using: self)
    }
    
    // MARK: - ApiServiceDelegate Conformance
    
    func onSuccess(_ response: CoinData) {
        uiDelegate?.onSuccess(response)
    }
    
    func onLoading(_ isLoading: Bool) {
        uiDelegate?.onLoading(isLoading)
    }
    
    func onError(_ error: ApiService.ErrorData) {
        uiDelegate?.onError(error)
    }
}


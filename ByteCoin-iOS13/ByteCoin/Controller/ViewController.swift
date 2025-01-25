//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CoinManagerUIUpdateDelegate {
    @IBOutlet weak var currencyLabel: UILabel!
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        
        currencyPicker.delegate = self
        
        coinManager.uiDelegate = self
        
        coinManager.getCoinPrice(for: coinManager.currencyArray.first!)
    }
    
    //MARK: - PickerViewDelegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
    
    //MARK: - CoinManagerDelegate
    
    func onLoading(_ isLoading: Bool) {
        
    }
    
    func onSuccess(_ response: CoinData) {
        currencyLabel.text = response.assetIdQuote
        bitcoinLabel.text = response.rate.decimalString(for: 2)
        
    }
    
    func onError(_ error: ApiService.ErrorData) {
        
    }
}


extension Double {
    func decimalString(for fraction: Int) -> String {
        return String(format:"%.\(fraction)f" , self)
    }
}

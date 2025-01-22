//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    var selectedTip: Double = 0.1

    var people: Int = 2
    
    var billPerPeople: Float = 0.0
    
    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var zeroPctButton: UIButton!
    
    @IBOutlet weak var tenPctButton: UIButton!
    
    @IBOutlet weak var twentyPctButton: UIButton!
    
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        
        let percent = sender.currentTitle
        
        resetButton()
        
        switch percent {
        case "0%":
            zeroPctButton.isSelected = true
            
            selectedTip = 0.0
        case "10%":
            tenPctButton.isSelected = true
            
            selectedTip = 0.1
        case "20%":
            twentyPctButton.isSelected = true
            
            selectedTip = 0.2
        default:
            return
        }
    }
    
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        let splitValue = Int(sender.value)
        
        splitNumberLabel.text = "\(splitValue)"
        
        people = splitValue
    }
    
    @IBAction func calculatePressed(_ sender: Any) {
        calculateSplitBill()
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    func calculateSplitBill() {
        guard let billString = billTextField.text else { return }
        
        let billFloat = Float(billString) ?? 0.0
        
        let billWithTip = billFloat * Float(selectedTip)
        
        let totalBill = billFloat + billWithTip
        
        let billPerPerson = totalBill / Float(people)
        
        billPerPeople = billPerPerson
    }
    
    func resetButton() {
        zeroPctButton.isSelected = false
        
        tenPctButton.isSelected = false
        
        twentyPctButton.isSelected = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            
            destinationVC.billPerPeople = billPerPeople;
            
            destinationVC.people = people
            
            destinationVC.tipPercentage = selectedTip * 100
        }
    }
}


//
//  ResultViewController.swift
//  Tipsy
//
//  Created by nicho@mac on 22/01/25.
//  Copyright © 2025 The App Brewery. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var billPerPeople: Float?
    
    var people: Int?
    
    var tipPercentage: Double?
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var settingLabel: UILabel!
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalLabel.text = "\(String(format: "%.2f", billPerPeople ?? 0.0))"
        
        settingLabel.text = "Split between \(people ?? 0) people with \(String(format : "%.0f",tipPercentage ?? 0) )% tip"
    }
    
    
}

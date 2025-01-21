//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by nicho@mac on 21/01/25.
//  Copyright © 2025 Angela Yu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    var bmi: BMI?
    
    @IBOutlet var backgroundView: UIView!
    
    @IBOutlet weak var bmiLabel: UILabel!
    
    @IBOutlet weak var adviceLabel: UILabel!
    
    @IBAction func recalculateButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bmiLabel.text = bmi?.getValueString()
        
        adviceLabel.text = bmi?.advice
        
        backgroundView.backgroundColor = bmi?.color
    }
    
}

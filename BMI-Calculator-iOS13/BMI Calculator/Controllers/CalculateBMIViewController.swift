//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateBMIViewController: UIViewController {
    @IBOutlet weak var heightLabel: UILabel!
    
    @IBOutlet weak var heightSlider: UISlider!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var weightSlider: UISlider!
    
    var calculateBMIBrain: CalculatorBMIBrain = CalculatorBMIBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func heightSliderChanged(_ sender: UISlider) {
        let formatedHeight = String(format: "%.2f", sender.value)
        
        heightLabel.text = "\(formatedHeight)m"
    }
    
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        let formatedWeight = String(format: "%.0f", sender.value)
        
        weightLabel.text = "\(formatedWeight)kg"
    }
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        let height = heightSlider.value
        let weight = weightSlider.value
        
        if height <= 0 || weight <= 0 {
              let alert = UIAlertController(
                  title: "Invalid Input",
                  message: "Height and Weight must be greater than 0.",
                  preferredStyle: .alert
              )
              
              alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
              
              self.present(alert, animated: true, completion: nil)
        }
        
        calculateBMIBrain.calculateBMI(h: height, w: weight)
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult"{
            let destinationVC = segue.destination as! ResultViewController
            
            destinationVC.bmi = calculateBMIBrain.bmi
        }
    }
}


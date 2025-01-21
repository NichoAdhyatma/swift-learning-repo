//
//  CalculatorBMIBrain.swift
//  BMI Calculator
//
//  Created by nicho@mac on 21/01/25.
//  Copyright © 2025 Angela Yu. All rights reserved.
//

struct CalculatorBMIBrain {
    var bmi: BMI?
    
    mutating func calculateBMI(h height: Float,w weight: Float) {
        let bmiValue =  weight / (height * height)
        
        bmi = BMI(value: bmiValue)
        
        classiyBMI()
    }
    
    mutating func classiyBMI() {
        guard let bmi = bmi else {
            return
        }
        
        switch bmi.value {
        case ..<16.0:
            bmi.advice = "Severely Underweight"
            bmi.color = .blue
        case 16.0..<18.5:
            bmi.advice = "Underweight"
            bmi.color = .cyan
        case 18.5..<25.0:
            bmi.advice = "Normal weight"
            bmi.color = .green
        case 25.0..<30.0:
            bmi.advice = "Overweight"
            bmi.color = .systemYellow
        case 30.0..<35.0:
            bmi.advice = "Obese Class I (Moderate)"
            bmi.color = .orange
        case 35.0..<40.0:
            bmi.advice = "Obese Class II (Severe)"
            bmi.color = .red
        case 40.0...:
            bmi.advice = "Obese Class III (Very Severe)"
            bmi.color = .purple
        default:
            bmi.color = .gray
        }
    }
}


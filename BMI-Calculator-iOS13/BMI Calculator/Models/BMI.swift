//
//  BMI.swift
//  BMI Calculator
//
//  Created by nicho@mac on 21/01/25.
//  Copyright © 2025 Angela Yu. All rights reserved.
//

import UIKit

class BMI {
    var value: Float
    var advice: String
    var color: UIColor
    
    init(value: Float = 0.0, advice: String = "No advice", color: UIColor = .gray) {
        self.value = value
        self.advice = advice
        self.color = color
    }
    
    func getValueString() -> String {
        return String(format: "%.1f", value)
    }
}

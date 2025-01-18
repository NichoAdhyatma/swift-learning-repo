//
//  Untitled.swift
//  Quizzler-iOS13
//
//  Created by nicho@mac on 18/01/25.
//  Copyright © 2025 The App Brewery. All rights reserved.
//

struct Question {
    let quest: String
    let options: [String]
    let answer: String
    
    init(q quest: String,a options: [String],correctAnswer answer: String) {
        self.quest = quest
        self.options = options
        self.answer = answer
    }
}

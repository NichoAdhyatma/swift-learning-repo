//
//  QuizBrain.swift
//  Quizzler-iOS13
//
//  Created by nicho@mac on 18/01/25.
//  Copyright © 2025 The App Brewery. All rights reserved.
//

struct QuizBrain {
    let questions: [Question] = [
        Question(q: "Which is the largest organ in the human body?", a: ["Heart", "Skin", "Large Intestine"], correctAnswer: "Skin"),
        Question(q: "Five dollars is worth how many nickels?", a: ["25", "50", "100"], correctAnswer: "100"),
        Question(q: "What do the letters in the GMT time zone stand for?", a: ["Global Meridian Time", "Greenwich Mean Time", "General Median Time"], correctAnswer: "Greenwich Mean Time"),
        Question(q: "What is the French word for 'hat'?", a: ["Chapeau", "Écharpe", "Bonnet"], correctAnswer: "Chapeau"),
        Question(q: "In past times, what would a gentleman keep in his fob pocket?", a: ["Notebook", "Handkerchief", "Watch"], correctAnswer: "Watch"),
        Question(q: "How would one say goodbye in Spanish?", a: ["Au Revoir", "Adiós", "Salir"], correctAnswer: "Adiós"),
        Question(q: "Which of these colours is NOT featured in the logo for Google?", a: ["Green", "Orange", "Blue"], correctAnswer: "Orange"),
        Question(q: "What alcoholic drink is made from molasses?", a: ["Rum", "Whisky", "Gin"], correctAnswer: "Rum"),
        Question(q: "What type of animal was Harambe?", a: ["Panda", "Gorilla", "Crocodile"], correctAnswer: "Gorilla"),
        Question(q: "Where is Tasmania located?", a: ["Indonesia", "Australia", "Scotland"], correctAnswer: "Australia")
    ]
    
    var questionNumber: Int = 0
    
    var quizScore: Int = 0
    
    func getCurrentQuestion() -> String {
        return questions[questionNumber].quest
    }
    
    func getCurrentOptions() -> [String] {
        return questions[questionNumber].options
    }
    
    mutating func nextQuestion() {
        if(questionNumber < questions.count - 1) {
            questionNumber += 1
        } else {
            quizScore = 0
            questionNumber = 0
        }
    }
    
    mutating func checkAnswer(is answer: String, onResult: @escaping (Bool) -> Void)-> Void {
        let result = answer == questions[questionNumber].answer
        
        if(result) {
            quizScore += 1
        }
        
        onResult(result)
    }
    
    func getProgress() -> Float {
        return Float(questionNumber) / Float(questions.count)
    }
}

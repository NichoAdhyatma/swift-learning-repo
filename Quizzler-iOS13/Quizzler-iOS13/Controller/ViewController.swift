//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var quizzBrain = QuizBrain()
    
    @IBOutlet weak var quizScoreLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var option1Button: UIButton!
    
    @IBOutlet weak var option2Button: UIButton!
    
    @IBOutlet weak var option3Button: UIButton!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        guard let answer = sender.currentTitle else { return }
        
        quizzBrain.checkAnswer(is: answer) { result in
            if result {
                sender.backgroundColor = .green
            } else {
                sender.backgroundColor = .red
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                [self] in
                sender.backgroundColor = .clear
                
                quizzBrain.nextQuestion()
                
                updateTitle()
                
                updateButtonTitle()
                
                updateScore()
                
                updateProgressBar()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTitle()
        
        updateButtonTitle()
    }
    
    func updateTitle() {
        titleLabel.text = quizzBrain.getCurrentQuestion()
    }
    
    func updateButtonTitle() {
        let options = quizzBrain.getCurrentOptions()
        
        option1Button.setTitle(options.first, for: .normal)
        
        option2Button.setTitle(options[1], for: .normal)
        
        option3Button.setTitle(options.last, for: .normal)
    }
    
    func updateScore() {
        quizScoreLabel.text = "Quiz Score : \(quizzBrain.quizScore)"
    }
    
    func updateProgressBar() {
        progressBar.setProgress(quizzBrain.getProgress(), animated: true)
    }
}


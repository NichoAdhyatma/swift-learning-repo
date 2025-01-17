//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController {
    var timer: Timer?
    var second: Int = 0
    var secondRemaining: Int = 0
    var player: AVAudioPlayer?
    
    enum HardnessTime: Int {
        case soft = 10
        case medium = 480
        case hard = 720
        case invalid = 0
        
        init(fromString string: String) {
            switch string {
            case "Soft":
                self = .soft
            case "Medium":
                self = .medium
            case "Hard":
                self = .hard
            default:
                self = .invalid
            }
        }
    }
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        guard let hardness = sender.currentTitle else { return }
        
        second = HardnessTime(fromString: hardness).rawValue
        
        resetProgressBar()
        
        startCountdown()
    }
    
    func countDownTimerSecond(onTick: @escaping (Int) -> Void, onFinish: @escaping () -> Void) {
        
        secondRemaining = second
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(
            withTimeInterval: 1.0, repeats: true
        ) {[self] timer in
            if secondRemaining > 0 {
                secondRemaining -= 1
                
                onTick(secondRemaining)
            } else {
                timer.invalidate()
                
                onFinish()
            }
        }
    }
    
    private func resetProgressBar() {
        progressBar?.progress = 0.0
    }
    
    private func startCountdown() {
        countDownTimerSecond(
            onTick: {_ in
                self.updateUI()
            },
            onFinish: {
                [self] in
                updateUIForCompletion()
                playFinisAlarm()
            }
        )
    }
    
    private func updateUI() {
        titleLabel.text = secondToMinutes(secondRemaining)
        
        progressBar?.progress = countProgressBar(secondRemaining: secondRemaining)
    }
    
    private func updateUIForCompletion() {
        titleLabel.text = "Time's Up!"
    }
    
    private func playFinisAlarm() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player?.play()
    }
    
    func countProgressBar(secondRemaining: Int) -> Float {
        return 1 - Float(secondRemaining) / Float(second)
    }
    
    func secondToMinutes(_ seconds: Int) -> String {
        let minutes = seconds / 60
        
        let secondsPart = seconds % 60
        
        return String(format: "%02d:%02d", minutes, secondsPart)
    }
}

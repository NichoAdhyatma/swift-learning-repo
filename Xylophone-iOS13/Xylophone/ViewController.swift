//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 28/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var player: AVAudioPlayer?
    
    var pressedButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func keyPressed(_ sender: UIButton) {
        pressedButton = sender
        
        guard let soundName: String = pressedButton?.currentTitle else { return }
        
        toggleOpacityButton(opacity: 0.5)
        
        playSound(name: soundName)
        
        toggleOpacityButton(opacity: 1, delay: 0.2)
    }
    
    func toggleOpacityButton(opacity: Double = 0, delay: Double = 0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            UIView.animate(withDuration: 0.1) {
                self.pressedButton?.alpha = opacity
            }
        }
    }
    
    func playSound(name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "wav") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default
            )
            
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try! AVAudioPlayer(
                contentsOf: url,
                fileTypeHint: AVFileType.wav.rawValue
            )
            
            player?.prepareToPlay()
            
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    
}




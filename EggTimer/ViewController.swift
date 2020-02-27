//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer?
    weak var timer: Timer?
    var secondsPassed = 0
    var fulltime = 0
    let eggTimes = [
        "Soft": 3,
        "Medium": 4,
        "Hard": 7
    ]

    @IBOutlet weak var cookingProgress: UIProgressView!
    @IBOutlet weak var topLabel: UILabel!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        cookingProgress.progress = 0.0
        secondsPassed = 0
        let hardness = sender.currentTitle!
        startTimer(seconds: eggTimes[hardness]!)
        topLabel.text = "We have set a timer for you :)"
        
    }
    func startTimer(seconds: Int) {
        timer?.invalidate()
        fulltime = seconds
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(_ timer: Timer){
        if secondsPassed < fulltime {
            secondsPassed += 1
            let progress = Float(secondsPassed)/Float(fulltime)
            cookingProgress.progress = progress
        } else {
            timer.invalidate()
            topLabel.text = "Done!"
            playSound()
        }
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}

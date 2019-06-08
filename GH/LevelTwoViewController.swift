//
//  LevelTwoViewController.swift
//  GH
//
//  Created by Adam Reed on 5/28/19.
//  Copyright © 2019 rdConcepts. All rights reserved.
//

import UIKit
import GoogleMobileAds
import AVKit

class LevelTwoViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        var testGoogleMob = "ca-app-pub-3940256099942544/2934735716"
        var realGoogleMob = "ca-app-pub-4186253562269967/4588599313"
        
        GoogleBannerView.adUnitID = testGoogleMob
        GoogleBannerView.rootViewController = self
        GoogleBannerView.load(GADRequest())
        
        
        guard let path = Bundle.main.path(forResource: "knock", ofType: "wav") else { return }
        let url = URL(fileURLWithPath: path)
        audioPlayer = try? AVAudioPlayer(contentsOf: url)
    }
    
    
    @IBOutlet weak var GoogleBannerView: GADBannerView!
    var timer = Timer()
    var timerIsRunning = false
    // VARIABLES
    @IBOutlet weak var firstTimer: UILabel!
    @IBOutlet weak var firstOffTimer: UILabel!
    @IBOutlet weak var secondTimer: UILabel!
    @IBOutlet weak var secondOffTimer: UILabel!
    @IBOutlet weak var thirdTimer: UILabel!
    
    @IBOutlet weak var minOnOne: UILabel!
    @IBOutlet weak var minOffOne: UILabel!
    @IBOutlet weak var minOnTwo: UILabel!
    @IBOutlet weak var minOffTwo: UILabel!
    @IBOutlet weak var minOnThree: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    // Set the pomodoro work and rest times.
    var levelOneTime = 180
    var levelTwoTime = 720
    var levelThreeTime = 720
    var restPeriodOne = 60
    var restPeriodTwo = 120
    
    
    // USEFUL FUNCTIONS
    func integerToClock (number: Int) -> String {
        let minutes = number / 60
        let seconds = String(number % 60)
        if seconds.count == 1 {
            let answer = "\(minutes):0\(seconds)"
            return answer
        } else {
            let answer = "\(minutes):\(seconds)"
            return answer
        }
    }
    
    func labelGoAway (label: UILabel, label2: UILabel) {
        label.alpha = 0
        label2.alpha = 0
    }
    
    func labelComeBack (label: UILabel, label2: UILabel) {
        label.alpha = 1
        label2.alpha = 1
        
    }
    
    func resetLevelTimers () {
        levelOneTime = 180
        levelTwoTime = 720
        levelThreeTime = 720
        restPeriodOne = 60
        restPeriodTwo = 120
    }
    
    func resetButton () {
        resetLevelTimers()
        firstTimer.text = integerToClock(number: levelOneTime)
        secondTimer.text = integerToClock(number: levelTwoTime)
        thirdTimer.text = integerToClock(number: levelThreeTime)
        firstOffTimer.text = integerToClock(number: restPeriodOne)
        secondOffTimer.text = integerToClock(number: restPeriodTwo)
        
        
        startButton.setTitle("START", for: .normal)
        print("Reset")
        labelComeBack(label: firstTimer, label2: minOnOne)
        labelComeBack(label: secondTimer, label2: minOnTwo)
        labelComeBack(label: thirdTimer, label2: minOnThree)
        labelComeBack(label: firstOffTimer, label2: minOffOne)
        labelComeBack(label: secondOffTimer, label2: minOffTwo)
        
        
        timer.invalidate()
    }
    
    
    // MAIN ACTION LOOP
    
    @IBAction func pressStart(_ sender: Any) {
        
        
        // Reset Button Functionality
        if startButton.title(for: .normal) == "RESET" {
            resetButton()
            timer.invalidate()
            startButton.setTitle("START", for: .normal)
            resetLevelTimers()
            return
        }
        
        // If timer is already running, do not let user start the timer again.
        if timerIsRunning == true {
            return
        }
        
        print("Started timer")
        timerIsRunning = true
        startButton.isEnabled = false
        startButton.alpha = 0.9
        audioPlayer?.play()
        flashWHite()
        startButton.setTitle("FOCUSING", for: .normal)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Clock), userInfo: nil, repeats: true)
    }
    
    
    @objc func Clock() {
        countDown()
    }
    
    // Takes a timer and decreases by 1
    // Updates the value of the label on iPhone
    func countDown () {
        
        //Run the timers if not at 0
        if levelOneTime != 0 {
            // Countdown the first timer
            levelOneTime -= 1
            firstTimer.text = integerToClock(number: levelOneTime)
            
        } else if restPeriodOne != 0 {
            if restPeriodOne == 60 {
                flashWHite()
                audioPlayer?.play()
                
                // Hide the labels from the previous opperation
                //Countdown the first rest period timer
                labelGoAway(label: firstTimer, label2: minOnOne)
                
            }
            
            restPeriodOne -= 1
            firstOffTimer.text = integerToClock(number: restPeriodOne)
            
        } else if levelTwoTime != 0 {
            if levelTwoTime == 720 {
                flashWHite()
                audioPlayer?.play()
                labelGoAway(label: firstOffTimer, label2: minOffOne)
            }
            
            
            
            levelTwoTime -= 1
            secondTimer.text = integerToClock(number: levelTwoTime)
            
        } else if restPeriodTwo != 0 {
            if restPeriodTwo == 120 {
                flashWHite()
                audioPlayer?.play()
                labelGoAway(label: secondTimer, label2: minOnTwo)
            }
            
            restPeriodTwo -= 1
            secondOffTimer.text = integerToClock(number: restPeriodTwo)
    
        } else if levelThreeTime != 0 {
            if levelThreeTime == 720 {
                flashWHite()
                audioPlayer?.play()
                labelGoAway(label: secondOffTimer, label2: minOffTwo)
            }
            
            levelThreeTime -= 1
            thirdTimer.text = integerToClock(number: levelThreeTime)
            
        } else {
            flashWHite()
            audioPlayer?.play()
            labelGoAway(label: thirdTimer, label2: minOnThree)
            timer.invalidate()
            timerIsRunning = false
            startButton.isEnabled = true
            startButton.alpha = 1
            startButton.setTitle("RESET", for: .normal)
        }
    }
    
    
    
    
    
    
    //screen flash
    func flashWHite() {
        if let wnd = self.view {
            
            var v = UIView(frame: wnd.bounds)
            v.backgroundColor = UIColor.white
            v.alpha = 0.85
            
            wnd.addSubview(v)
            UIView.animate(withDuration: 1.0, animations: {
                v.alpha = 0.0
            }, completion: {(finished:Bool) in
                print("Flash!")
                v.removeFromSuperview()
            })
        }
    }
}


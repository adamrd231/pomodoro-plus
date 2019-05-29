//
//  LevelThreeViewController.swift
//  GH
//
//  Created by Adam Reed on 5/28/19.
//  Copyright © 2019 rdConcepts. All rights reserved.
//


import UIKit

class LevelThreeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
    }
    
    
    var timer = Timer()
    var timerIsRunning = false
    // VARIABLES
    @IBOutlet weak var firstTimer: UILabel!
    @IBOutlet weak var secondTimer: UILabel!
    @IBOutlet weak var thirdTimer: UILabel!
    @IBOutlet weak var fourthTimer: UILabel!
    @IBOutlet weak var firstOffTimer: UILabel!
    @IBOutlet weak var secondOffTimer: UILabel!
    @IBOutlet weak var thirdOffTimer: UILabel!
    @IBOutlet weak var minOnOne: UILabel!
    @IBOutlet weak var minOnTwo: UILabel!
    @IBOutlet weak var minOnThree: UILabel!
    @IBOutlet weak var minOnFour: UILabel!
    @IBOutlet weak var minOffOne: UILabel!
    @IBOutlet weak var minOffTwo: UILabel!
    @IBOutlet weak var minOffThree: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    
    // Set the pomodoro work and rest times.
    var levelOneTime = 300
    var levelTwoTime = 780
    var levelThreeTime = 1020
    var levelFourTime = 1020
    var restPeriodOne = 60
    var restPeriodTwo = 120
    var restPeriodThree = 300
    
    
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
        levelOneTime = 300
        levelTwoTime = 780
        levelThreeTime = 1020
        levelFourTime = 1020
        restPeriodOne = 60
        restPeriodTwo = 120
        restPeriodThree = 300
    }
    
    func resetButton () {
        resetLevelTimers()
        firstTimer.text = integerToClock(number: levelOneTime)
        secondTimer.text = integerToClock(number: levelTwoTime)
        thirdTimer.text = integerToClock(number: levelThreeTime)
        fourthTimer.text = integerToClock(number: levelFourTime)
        firstOffTimer.text = integerToClock(number: restPeriodOne)
        secondOffTimer.text = integerToClock(number: restPeriodTwo)
        thirdOffTimer.text = integerToClock(number: restPeriodThree)
        
        
        startButton.setTitle("START", for: .normal)
        print("Reset")
        labelComeBack(label: firstTimer, label2: minOnOne)
        labelComeBack(label: secondTimer, label2: minOnTwo)
        labelComeBack(label: thirdTimer, label2: minOnThree)
        labelComeBack(label: fourthTimer, label2: minOnFour)
        labelComeBack(label: firstOffTimer, label2: minOffOne)
        labelComeBack(label: secondOffTimer, label2: minOffTwo)
        labelComeBack(label: thirdOffTimer, label2: minOffThree)
        
        
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
            
            // Hide the labels from the previous opperation
            //Countdown the first rest period timer
            labelGoAway(label: firstTimer, label2: minOnOne)
            restPeriodOne -= 1
            firstOffTimer.text = integerToClock(number: restPeriodOne)
            
        } else if levelTwoTime != 0 {
            labelGoAway(label: firstOffTimer, label2: minOffOne)
            levelTwoTime -= 1
            secondTimer.text = integerToClock(number: levelTwoTime)
            
        } else if restPeriodTwo != 0 {
            labelGoAway(label: secondTimer, label2: minOnTwo)
            restPeriodTwo -= 1
            secondOffTimer.text = integerToClock(number: restPeriodTwo)
            
        } else if levelThreeTime != 0 {
            labelGoAway(label: secondOffTimer, label2: minOffTwo)
            levelThreeTime -= 1
            thirdTimer.text = integerToClock(number: levelThreeTime)
            
        } else if restPeriodThree != 0 {
            labelGoAway(label: thirdTimer, label2: minOnThree)
            restPeriodThree -= 1
            thirdOffTimer.text = integerToClock(number: restPeriodThree)
            
        } else if levelFourTime != 0 {
            labelGoAway(label: thirdOffTimer, label2: minOffThree)
            levelFourTime -= 1
            fourthTimer.text = integerToClock(number: levelFourTime)
            
        } else {
            labelGoAway(label: fourthTimer, label2: minOnFour)
            timer.invalidate()
            timerIsRunning = false
            startButton.isEnabled = true
            startButton.alpha = 1
            startButton.setTitle("RESET", for: .normal)
        }
    }
    
    
    
}



//
//  TimerViewController.swift
//  GH
//
//  Created by Adam Reed on 12/9/18.
//  Copyright © 2018 rdConcepts. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
    }
  
    
    // VARIABLES
    var timer = Timer()
    
    var timerIsRunning = false
    //:Mark Label Variables
    @IBOutlet weak var doneLabel: UILabel!
    
    // Numbers for clock display on timers
    @IBOutlet weak var firstTimer: UILabel!
    @IBOutlet weak var secondTimer: UILabel!
    @IBOutlet weak var offTimerOne: UILabel!

    // Minutes ON or OFF label
    @IBOutlet weak var minOnOne: UILabel!
    @IBOutlet weak var MinOffOne: UILabel!
    @IBOutlet weak var minOnTwo: UILabel!
    
    // Start Button Display
    @IBOutlet weak var startButton: UIButton!


    // Set the pomodoro work and rest times.
    var levelOneTime = 300
    var levelTwoTime = 600
    var restPeriod = 120

    
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
            
        } else if restPeriod != 0 {
            
            // Hide the labels from the previous opperation
            //Countdown the first rest period timer
            labelGoAway(label: firstTimer, label2: minOnOne)
            restPeriod -= 1
            offTimerOne.text = integerToClock(number: restPeriod)
            
        } else if levelTwoTime != 0 {
            labelGoAway(label: offTimerOne, label2: MinOffOne)
            levelTwoTime -= 1
            secondTimer.text = integerToClock(number: levelTwoTime)
            
        }  else {
            labelGoAway(label: secondTimer, label2: minOnTwo)
            timer.invalidate()
            timerIsRunning = false
            startButton.isEnabled = true
            startButton.alpha = 1
            startButton.setTitle("RESET", for: .normal)
        }
    }
    
    func resetButton () {
        resetLevelTimers()
        firstTimer.text = integerToClock(number: levelOneTime)
        secondTimer.text = integerToClock(number: levelTwoTime)
        offTimerOne.text = integerToClock(number: restPeriod)
        
        
        startButton.setTitle("START", for: .normal)
        print("Reset")
        labelComeBack(label: firstTimer, label2: minOnOne)
        labelComeBack(label: secondTimer, label2: minOnTwo)
        labelComeBack(label: offTimerOne, label2: MinOffOne)


        timer.invalidate()
    }
    
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
        levelTwoTime = 600
        restPeriod = 120
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

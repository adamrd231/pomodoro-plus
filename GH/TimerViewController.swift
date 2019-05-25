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
    
    @IBOutlet weak var doneLabel: UILabel!
    
    @IBOutlet weak var levelOneLabel: UILabel!
    @IBOutlet weak var levelTwoLabel: UILabel!
    @IBOutlet weak var levelThreeLabel: UILabel!
    @IBOutlet weak var levelFourLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!

    @IBOutlet weak var minOnOne: UILabel!
    @IBOutlet weak var offLabelOne: UILabel!
    @IBOutlet weak var minOnTwo: UILabel!
    @IBOutlet weak var offLabelTwo: UILabel!
    @IBOutlet weak var minOnThree: UILabel!
    @IBOutlet weak var offLabelThree: UILabel!
    @IBOutlet weak var minOnFour: UILabel!
    @IBOutlet weak var backgroundMinOnOne: UILabel!
    @IBOutlet weak var secondsOffOne: UILabel!
    @IBOutlet weak var backgroundMinOnTwo: UILabel!
    @IBOutlet weak var secondsOffTwo: UILabel!
    @IBOutlet weak var backgroundMinOnThree: UILabel!
    @IBOutlet weak var secondsOffThree: UILabel!
    @IBOutlet weak var backgroundMinOnFour: UILabel!
    
    @IBOutlet weak var restLabel1: UILabel!
    @IBOutlet weak var restLabel2: UILabel!
    @IBOutlet weak var restLabel4: UILabel!

    
    var levelOneTime = 3
    var levelTwoTime = 5
    var levelThreeTime = 5
    var levelFourTime = 10
    
    var restPeriod = 3
    var restPeriod2 = 3
    var restPeriod3 = 3
    
    
    @IBAction func pressStart(_ sender: Any) {
        if startButton.title(for:.normal) == "RESET" {
            resetGoofhead()
            print("RESET WORKS")
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
        startButton.setTitle("FOCUSED AF", for: .normal)
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
            levelOneLabel.text = integerToClock(number: levelOneTime)
            
        } else if restPeriod != 0 {
            // Hide the labels from the previous opperation
            labelGoAway(label: levelOneLabel, label2: minOnOne, label3: backgroundMinOnOne)
            //Countdown the first rest period timer
            restPeriod -= 1
            restLabel1.text = integerToClock(number: restPeriod)
            
        } else if levelTwoTime != 0 {
            labelGoAway(label: restLabel1, label2: offLabelOne, label3: secondsOffOne)
            levelTwoTime -= 1
            levelTwoLabel.text = integerToClock(number: levelTwoTime)
            
        } else if restPeriod2 != 0 {
            labelGoAway(label: levelTwoLabel, label2: minOnTwo, label3: backgroundMinOnTwo)
            restPeriod2 -= 1
            restLabel2.text = integerToClock(number: restPeriod2)
            
            
        } else if levelThreeTime != 0 {
            labelGoAway(label: restLabel2, label2: offLabelTwo, label3: secondsOffTwo)
            levelThreeTime -= 1
            levelThreeLabel.text = integerToClock(number: levelThreeTime)
            
        } else if restPeriod3 != 0 {
            labelGoAway(label: levelThreeLabel, label2: minOnThree, label3: backgroundMinOnThree)
            restPeriod3 -= 1
            restLabel4.text = integerToClock(number: restPeriod3)
            
        } else if levelFourTime != 0 {
            labelGoAway(label: restLabel4, label2: offLabelThree, label3: secondsOffThree)
            levelFourTime -= 1
            levelFourLabel.text = integerToClock(number: levelFourTime)
            
        }  else {
            labelGoAway(label: levelFourLabel, label2: minOnFour, label3: backgroundMinOnFour)
            timer.invalidate()
            timerIsRunning = false
            startButton.isEnabled = true
            startButton.alpha = 1
            doneLabel.alpha = 1
            startButton.setTitle("RESET", for: .normal)
        }
    }
    
    func resetGoofhead () {
        levelOneTime = 3
        levelOneLabel.text = integerToClock(number: levelOneTime)
        levelTwoTime = 5
        levelTwoLabel.text = integerToClock(number: levelTwoTime)
        levelThreeTime = 5
        levelThreeLabel.text = integerToClock(number: levelThreeTime)
        levelFourTime = 10
        levelFourLabel.text = integerToClock(number: levelFourTime)
        restPeriod = 3
        restLabel1.text = integerToClock(number: restPeriod)
        restPeriod2 = 3
        restLabel2.text = integerToClock(number: restPeriod2)
        restPeriod3 = 3
        restLabel4.text = integerToClock(number: restPeriod3)
        startButton.setTitle("START", for: .normal)
        print("Reset")
        labelComeBack(label: levelOneLabel, label2: minOnOne, label3: backgroundMinOnOne)
        labelComeBack(label: levelTwoLabel, label2: minOnTwo, label3: backgroundMinOnTwo)
        labelComeBack(label: levelThreeLabel, label2: minOnThree, label3: backgroundMinOnThree)
        labelComeBack(label: levelFourLabel, label2: minOnFour, label3: backgroundMinOnFour)
        labelComeBack(label: restLabel1, label2: offLabelOne, label3: secondsOffOne)
        labelComeBack(label: restLabel2, label2: offLabelTwo, label3: secondsOffTwo)
        labelComeBack(label: restLabel4, label2: offLabelThree, label3: secondsOffThree)
        doneLabel.alpha = 0
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
 
    func labelGoAway (label: UILabel, label2: UILabel, label3:UILabel) {
        label.alpha = 0
        label2.alpha = 0
        label3.alpha = 0
    }
    
    func labelComeBack (label: UILabel, label2: UILabel, label3: UILabel) {
        label.alpha = 1
        label2.alpha = 1
        label3.alpha = 1
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

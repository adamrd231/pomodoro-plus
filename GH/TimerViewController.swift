//
//  TimerViewController.swift
//  GH
//
//  Created by Adam Reed on 12/9/18.
//  Copyright © 2018 rdConcepts. All rights reserved.
//

import UIKit
import GoogleMobileAds
import AVFoundation


class TimerViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        GoogleBannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        GoogleBannerView.rootViewController = self
        GoogleBannerView.load(GADRequest())
        
        guard let path = Bundle.main.path(forResource: "knock", ofType: "wav") else { return }
        let url = URL(fileURLWithPath: path)
        audioPlayer = try? AVAudioPlayer(contentsOf: url)
        audioPlayer?.prepareToPlay()
        
    }
  
    @IBOutlet weak var GoogleBannerView: GADBannerView!
    
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
    class LevelTimers {
        var levelOne = 3
        var levelTwo = 3
        var restOne = 3
    }
    
    var LevelTimer = LevelTimers()
    
    
    var levelOneTime = 3
    var levelTwoTime = 3
    var restPeriod = 3

    //:  START
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
        audioPlayer?.play()
        flashWHite()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Clock), userInfo: nil, repeats: true)
    }
    
    
    @objc func Clock() {
        countDown()
    }
    
    //var soundPlayer = AVPlayer.init(url: URL(string: "knock.wav")!)
    
    
    // Main Logic for String Timers
    func countDown () {
        
        //Run the timers if not at 0
        if LevelTimer.levelOne != 0 {
            // Countdown the first timer
            LevelTimer.levelOne -= 1
            firstTimer.text = integerToClock(number: LevelTimer.levelOne)
            
        } else if LevelTimer.restOne != 0 {
            if LevelTimer.restOne == 3 {
                flashWHite()
                audioPlayer?.play()
                
                // Hide the labels from the previous opperation
                //Countdown the first rest period timer
                labelGoAway(label: firstTimer, label2: minOnOne)
            
            }
    
            
            LevelTimer.restOne -= 1
            offTimerOne.text = integerToClock(number: LevelTimer.restOne)
            
        } else if LevelTimer.levelTwo != 0 {
            if LevelTimer.levelTwo == 3 {
                audioPlayer?.play()
                flashWHite()
            }
            labelGoAway(label: offTimerOne, label2: MinOffOne)
            LevelTimer.levelTwo -= 1
            secondTimer.text = integerToClock(number: LevelTimer.levelTwo)
            
        }  else {
            audioPlayer?.play()
            flashWHite()

            labelGoAway(label: secondTimer, label2: minOnTwo)
            timer.invalidate()
            timerIsRunning = false
            startButton.isEnabled = true
            startButton.alpha = 1
            startButton.setTitle("RESET", for: .normal)
        }
    }
    
    
    
    
    
    // Supporting Functions
    
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
        LevelTimer.levelOne = 300
        LevelTimer.levelTwo = 600
        LevelTimer.restOne = 120
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

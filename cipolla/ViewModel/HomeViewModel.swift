//
//  HomeViewModel.swift
//  cipolla
//
//  Created by Adam Reed on 8/24/23.
//

import SwiftUI

enum TimerStates {
    case isRunning
    case isPaused
    case isDone
}

struct PomodoroTimermodel {
    var pomodoroTime: Double = 10
    var breakTime: Double = 5
    var rounds: Int = 2
    var isTimerRunning: TimerStates = .isPaused
}

class HomeViewModel: ObservableObject {
    @Published var pomodoroTimer = PomodoroTimermodel()
    @Published var backUpPomodoroTimer = PomodoroTimermodel()

    @Published var taskList: [Task] = []
    @Published var newTask: String = ""
    
    var timer = Timer()

    func startTimer() {
        // Timer is running, update state and
        pomodoroTimer.isTimerRunning = .isRunning
        // Save backup for resetting values
        backUpPomodoroTimer = pomodoroTimer
        // Start timer
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            // Check to make sure there are rounds left in the timer
            guard self.pomodoroTimer.rounds > 0 else {
                self.pauseTimer()
                self.pomodoroTimer.isTimerRunning = .isDone
                return
            }
            
            // Check to make sure there is time left on the pomodoro timer
            guard self.pomodoroTimer.pomodoroTime != 0 else {
                self.pomodoroTimer.breakTime -= 1
                
                guard self.pomodoroTimer.breakTime != 0 else {
                    self.pomodoroTimer.rounds -= 1
                    guard self.pomodoroTimer.rounds != 0 else {
                        return 
                    }
                    self.resetTimer()
                    return
                }
                return
            }

            self.pomodoroTimer.pomodoroTime -= 1
        }
    }
    
    func resetTimer() {
        pomodoroTimer.pomodoroTime = backUpPomodoroTimer.pomodoroTime
        pomodoroTimer.breakTime = backUpPomodoroTimer.breakTime
    }
    
    func totalReset() {
        pomodoroTimer = backUpPomodoroTimer
    }
    
    func pauseTimer() {
        self.timer.invalidate()
        pomodoroTimer.isTimerRunning = .isPaused
    }
}

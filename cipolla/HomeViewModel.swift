//
//  HomeViewModel.swift
//  cipolla
//
//  Created by Adam Reed on 8/24/23.
//

import SwiftUI

struct PomodoroTimermodel {
    var pomodoroTime: Double = 10
    var breakTime: Double = 5
    var isTimerRunning: Bool = false
}

class HomeViewModel: ObservableObject {
    @Published var pomodoroTimer = PomodoroTimermodel()
    var timer = Timer()
    
    func startTimer() {
        pomodoroTimer.isTimerRunning = true
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.pomodoroTimer.pomodoroTime -= 1
            
            if self.pomodoroTimer.pomodoroTime == 0 {
                self.pauseTimer()
            }
        }
    }
    
    func pauseTimer() {
        print("Stop timer")
        self.timer.invalidate()
        pomodoroTimer.isTimerRunning = false
    }
}

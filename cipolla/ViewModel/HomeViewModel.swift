//
//  HomeViewModel.swift
//  cipolla
//
//  Created by Adam Reed on 8/24/23.
//

import SwiftUI
import StoreKit
import Combine

enum TimerStates {
    case notStarted
    case isRunning
    case isPaused
    case isDone
}

struct PomodoroTimermodel {
    var pomodoroTime: Double = 1500
    var breakTime: Double = 300
    var rounds: Int = 2
    var isTimerRunning: TimerStates = .notStarted
   
    var timerOptionSelection = TimerOptions.pomodoro
    var timerOptions:[TimerOptions] = [.pomodoro, .shortBreak]
}

class HomeViewModel: ObservableObject {
    @Published var pomodoroTimer = PomodoroTimermodel()
    @Published var backUpPomodoroTimer = PomodoroTimermodel()
    @Published var taskList: [PomodoroTask] = []
    @Published var newTask: String = ""
    
    @Published var store = StoreManager()
    
    @Published var inAppPurchases:Set<Product> = []
    
    let adsVM = AdsViewModel.shared
    
    var timer = Timer()
    
    // Cancellable for subscribers
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        store.$purchasedNonConsumables
            .sink { [weak self] (purchases) in
                self?.inAppPurchases = purchases
            }
            .store(in: &cancellable)
    }
    
    func addItemToTaskList() {
        guard newTask != "" else { return }
        // Create new Task
        let new = PomodoroTask(name: newTask, isComplete: false)
        // Append item to list
        taskList.append(new)
        // clear our the input field
        newTask = ""
    }
    
    func runTimer() {
        // Timer is running, update state and
        pomodoroTimer.isTimerRunning = .isRunning
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.pomodoroTimer.pomodoroTime == 0 {
                self.pomodoroTimer.timerOptionSelection = .shortBreak
            }
            
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
                    self.pomodoroTimer.timerOptionSelection = .pomodoro
                    return
                }
                return
            }

            self.pomodoroTimer.pomodoroTime -= 1
            
            
        }
    }

    func startTimer() {
        // Save backup for resetting values
        backUpPomodoroTimer = pomodoroTimer
        // Start timer
        runTimer()
        
    }
    
    func resetTimer() {
        pomodoroTimer.pomodoroTime = backUpPomodoroTimer.pomodoroTime
        pomodoroTimer.breakTime = backUpPomodoroTimer.breakTime
    }
    
    func totalReset() {
        pomodoroTimer.isTimerRunning = .notStarted
        pomodoroTimer.timerOptionSelection = .pomodoro
        pomodoroTimer = backUpPomodoroTimer
        if !store.purchasedNonConsumables.contains(where: { $0.displayName == "Remove Advertising"}) {
            adsVM.interstitial.showAd()
        }
    }
    
    func pauseTimer() {
        self.timer.invalidate()
        pomodoroTimer.isTimerRunning = .isPaused
    }
}

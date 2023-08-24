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
    
}

class HomeViewModel: ObservableObject {
    @Published var pomodoroTimer = PomodoroTimermodel()
}

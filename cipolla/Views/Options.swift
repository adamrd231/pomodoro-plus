//
//  Options.swift
//  cipolla
//
//  Created by Adam Reed on 8/25/23.
//

import SwiftUI

struct Options: View {
    
    @Binding var pomodoroOptions: PomodoroTimermodel
    
    var body: some View {
        VStack {
            Text("Options")
            List {
                HStack {
                    Text("Rounds")
                    Text(pomodoroOptions.rounds.description)
                        .bold()
                    Spacer()
                    Stepper("", value: $pomodoroOptions.rounds, in: 0...10)

                }
                HStack {
                    Text("Pomodoro time")
                    TimerView(time: pomodoroOptions.pomodoroTime)
                        .bold()
                    Spacer()
                    Stepper("", value: $pomodoroOptions.pomodoroTime, in: 60...1800, step: 60)
                }
                HStack {
                    Text("Break time")
                    TimerView(time: pomodoroOptions.breakTime)
                        .bold()
                    Spacer()
                    Stepper("", value: $pomodoroOptions.breakTime, in: 60...600, step: 60)
                }
            }
        }
    }
}

struct Options_Previews: PreviewProvider {
    static var previews: some View {
        Options(pomodoroOptions: .constant(PomodoroTimermodel()))
    }
}

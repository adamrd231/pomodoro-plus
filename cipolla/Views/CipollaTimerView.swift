//
//  CipollaTimerView.swift
//  cipolla
//
//  Created by Adam Reed on 8/25/23.
//

import SwiftUI

struct CipollaTimerView: View {
    @EnvironmentObject var vm: HomeViewModel
    
    var body: some View {
        VStack {
            // Top portion of screen
            VStack(spacing: 5) {
                Text("Cipolla")
                    .font(.caption)
                
                Text(vm.pomodoroTimer.rounds == 0 ? "done" : "\(vm.pomodoroTimer.rounds.description) Rounds")
                    .font(.title3)
                    .fontWeight(.bold)
                
               
                
                switch vm.pomodoroTimer.timerOptionSelection {
                    case .pomodoro: TimerView(time: vm.pomodoroTimer.pomodoroTime)
                    case .shortBreak: TimerView(time: vm.pomodoroTimer.breakTime)
                }
                   
                Picker("hello", selection: $vm.pomodoroTimer.timerOptionSelection) {
                    ForEach(vm.pomodoroTimer.timerOptions, id: \.self) { option in
                        Text(option.description)
                    }
                }
                .pickerStyle(.segmented)
                .fixedSize()
            }
            .padding()
            
            List {
                VStack(alignment: .center) {
                    TextField("What's the focus?", text: $vm.newTask)
                    HStack {
                        Button("Add task") {
                            print("Add task to list for current pomodoro")
                            vm.addItemToTaskList()
                            
                        }
                        .disabled(vm.pomodoroTimer.isTimerRunning == .isRunning)
                        Spacer()
                    }
                   
                }
                ForEach($vm.taskList, id: \.self, editActions: .delete) { $task in
                    HStack {
                        Toggle("", isOn: $task.isComplete)
                            .toggleStyle(CheckboxToggleStyle())
                            .fixedSize()
                        Text(task.name)
                    }
                }
                Button("Clear list") {
                    vm.taskList = []
                }
                .disabled(vm.pomodoroTimer.isTimerRunning == .isRunning)
                
            }
            .frame(width: UIScreen.main.bounds.width)
            .frame(maxWidth: .infinity)
            
            Button {
                print("Something")
                switch vm.pomodoroTimer.isTimerRunning {
                    case .isPaused: vm.startTimer()
                    case .isRunning: vm.pauseTimer()
                    case .isDone: vm.totalReset()
                }
            } label: {
                switch vm.pomodoroTimer.isTimerRunning {
                    case .isPaused: Text("Time to focus")
                    case .isRunning: Text("Pause")
                    case .isDone: Text("Reset")
                }
            }
          
        }
        .padding()
    }
}

struct CipollaTimerView_Previews: PreviewProvider {
    static var previews: some View {
        CipollaTimerView()
    }
}

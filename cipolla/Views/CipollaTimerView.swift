//
//  CipollaTimerView.swift
//  cipolla
//
//  Created by Adam Reed on 8/25/23.
//

import SwiftUI

struct CipollaTimerView: View {
    @EnvironmentObject var vm: HomeViewModel
    @State var isShowingResetConfirmation: Bool = false
    
    var body: some View {
        VStack {
            // Top portion of screen
            VStack(spacing: 0) {
                Image("onion-icon")
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .center)
                
                Text(vm.pomodoroTimer.rounds == 0 ? "done" : "\(vm.pomodoroTimer.rounds.description) Rounds")
                    .font(.title)
                    .fontWeight(.bold)
                
                switch vm.pomodoroTimer.timerOptionSelection {
                    case .pomodoro: TimerView(time: vm.pomodoroTimer.pomodoroTime)
                        .font(.system(size: 100, weight: .bold, design: .rounded))
                    case .shortBreak: TimerView(time: vm.pomodoroTimer.breakTime)
                        .font(.system(size: 100, weight: .bold, design: .rounded))
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
                        Button{
                            print("Add task to list for current pomodoro")
                            vm.addItemToTaskList()
                        } label: {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                Text("Add task")
                            }
                        }
                        .buttonStyle(ListButton())
                        .disabled(vm.pomodoroTimer.isTimerRunning == .isRunning || vm.newTask == "")
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
                Button {
                    vm.taskList = []
                } label: {
                    HStack {
                        Image(systemName: "xmark.circle")
                        Text("Clear list")
                    }
                }
                .buttonStyle(ListButton())
                .disabled(vm.pomodoroTimer.isTimerRunning == .isRunning || vm.taskList.count == 0)
                
            }
            .frame(width: UIScreen.main.bounds.width)
            .frame(maxWidth: .infinity)
            
            
            VStack {
                Button {
                    print("Something")
                    switch vm.pomodoroTimer.isTimerRunning {
                        case .notStarted: vm.startTimer()
                        case .isPaused: vm.runTimer()
                        case .isRunning: vm.pauseTimer()
                        case .isDone: vm.totalReset()
                    }
                } label: {
                    switch vm.pomodoroTimer.isTimerRunning {
                        case .notStarted: HStack {
                            Image(systemName: "highlighter")
                            Text("Time to focus")
                        }
                        case .isPaused: HStack {
                            Image(systemName: "highlighter")
                            Text("Restart the focus")
                        }
                        case .isRunning: HStack {
                            Image(systemName: "pause")
                            Text("Pause")
                        }
                        case .isDone: HStack {
                            Image(systemName: "arrow.uturn.forward")
                            Text("Reset")
                        }
                    }
                }
                .buttonStyle(GreenButton())
                
                Button {
                    isShowingResetConfirmation.toggle()
                } label: {
                    HStack {
                        Image(systemName: "arrow.uturn.backward")
                        Text("Reset")
                    }
                }
                .buttonStyle(GreenButton())
                .confirmationDialog("", isPresented: $isShowingResetConfirmation) {
                    Button("You sure you want to reset?") {
                        vm.pauseTimer()
                        vm.totalReset()
                    }
                }
            }
            Banner(width: UIScreen.main.bounds.width)
        }
        .padding()
    }
}

struct GreenButton: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(isEnabled ? Color.theme.green : Color.theme.green.opacity(0.3))
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.theme.green.opacity(0.2))
            .cornerRadius(15)

    }
}

struct ListButton: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(isEnabled ? Color.theme.green : Color.theme.green.opacity(0.2))
    }
}

struct CipollaTimerView_Previews: PreviewProvider {
    static var previews: some View {
        CipollaTimerView()
    }
}

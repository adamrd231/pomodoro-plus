//
//  ContentView.swift
//  cipolla
//
//  Created by Adam Reed on 6/28/22.
//

import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
 
            RoundedRectangle(cornerRadius: 5.0)
                .stroke(lineWidth: 3)
                .frame(width: 25, height: 25)
                .cornerRadius(5.0)
                .overlay {
                    Image(systemName: configuration.isOn ? "checkmark" : "")
                }
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }
            configuration.label
        }
    }
}

struct Task: Hashable {
    var name: String
    var isComplete: Bool
}

struct TimerView: View {
    
    let time: Double
    
    var body: some View {
        HStack(spacing: .zero) {
            Text(Int((time / 60)), format: .number)
            Text(":")
            if time.truncatingRemainder(dividingBy: 60) < 10 {
                Text("0")
            }
            Text((time.truncatingRemainder(dividingBy: 60)), format: .number)
           
        }
        .font(.largeTitle)
    }
}

struct HomeView: View {
    
    @StateObject var vm = HomeViewModel()
    @State var newTask: String = ""
    
    @State var taskList: [Task] = []
    
    func addItemToTaskList() {
        guard newTask != "" else { return }
        // Create new Task
        let new = Task(name: newTask, isComplete: false)
        // Append item to list
        taskList.append(new)
        // clear our the input field
        newTask = ""
    }
    
    var body: some View {
        // Status showing what step user is on
        VStack(alignment: .center) {
            Text("Cipolla")
                .font(.caption)
            
            Text("Pomodoro / focus")
            TimerView(time: vm.pomodoroTimer.pomodoroTime)
            
               
            List {
                VStack(alignment: .center) {
                    TextField("What's the focus?", text: $newTask)
                    HStack {
                        Button("Add task") {
                            print("Add task to list for current pomodoro")
                            addItemToTaskList()
                            
                        }
                        Spacer()
                    }
                   
                }
                ForEach($taskList, id: \.self, editActions: .delete) { $task in
                    HStack {
                        Toggle("", isOn: $task.isComplete)
                            .toggleStyle(CheckboxToggleStyle())
                            .fixedSize()
                        Text(task.name)
                    }
                }
                Button("Clear list") {
                    taskList = []
                }
                
            }
            .frame(width: UIScreen.main.bounds.width)
            .frame(maxWidth: .infinity)
            
            Button(vm.pomodoroTimer.isTimerRunning ?  "Pause" : "Time to focus!") {
                print("This will start the timer")
                vm.pomodoroTimer.isTimerRunning ? vm.pauseTimer() : vm.startTimer()
            }
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(vm: HomeViewModel())
    }
}

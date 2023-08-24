import SwiftUI

struct HomeView: View {
    @StateObject var vm = HomeViewModel()
    
    func addItemToTaskList() {
        guard vm.newTask != "" else { return }
        // Create new Task
        let new = Task(name: vm.newTask, isComplete: false)
        // Append item to list
        vm.taskList.append(new)
        // clear our the input field
        vm.newTask = ""
    }
    
    var body: some View {
        // Status showing what step user is on
        VStack(alignment: .center) {
            Text("Cipolla")
                .font(.caption)
            
            
            Text("Rounds \(vm.pomodoroTimer.rounds.description)")
            HStack {
                Text("Pomodoro / focus")
                TimerView(time: vm.pomodoroTimer.pomodoroTime)
                
                Text("Break / rest")
                TimerView(time: vm.pomodoroTimer.breakTime)
            }
           
               
            List {
                VStack(alignment: .center) {
                    TextField("What's the focus?", text: $vm.newTask)
                    HStack {
                        Button("Add task") {
                            print("Add task to list for current pomodoro")
                            addItemToTaskList()
                            
                        }
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
                    case .isPaused: Text("Timer to focus")
                    case .isRunning: Text("Pause")
                    case .isDone: Text("Reset")
                }
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

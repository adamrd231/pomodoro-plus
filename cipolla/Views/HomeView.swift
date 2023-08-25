import SwiftUI

enum TimerOptions: String {
    case pomodoro
    case shortBreak
    
    var description: String {
        switch self {
        case .pomodoro: return "Pomodoro"
        case .shortBreak: return "Break"
        }
    }
}

struct HomeView: View {
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        // Status showing what step user is on
        TabView {
            CipollaTimerView()
                .environmentObject(vm)
                .tabItem {
                    VStack {
                        Text("Home")
                        Image(systemName: "house")
                    }
                }
            
            Options(pomodoroOptions: $vm.pomodoroTimer)
                .tabItem {
                    VStack {
                        Text("Options")
                        Image(systemName: "option")
                    }
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(vm: HomeViewModel())
    }
}

//
//  ContentView.swift
//  cipolla
//
//  Created by Adam Reed on 6/28/22.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm = HomeViewModel()
    @State var newTask: String = ""
    
    var body: some View {
        // Status showing what step user is on
        VStack {
            Text("Pomodoro / focus")
            Text(vm.time.description)
            Button("Time to focus!") {
                print("This will start the timer")
            }
               
            TextField("Tasks", text: $newTask)
            Button("Add task") {
                print("Add task to list for current pomodoro")
            }
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

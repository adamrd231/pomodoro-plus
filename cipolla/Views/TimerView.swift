import SwiftUI

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
//        .font(.custom("", size: 100))
    }
}

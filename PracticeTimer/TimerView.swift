//
//  ContentView.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 30/04/2022.
//

import SwiftUI

struct TimerView: View {
    enum Mode {
        case work
        case rest
        case stopped
    }
    func startPressed() {
        if mode == .work { mode = .stopped }
        else { mode = .work }
        print(mode)
        
    }
    @State private var mode: Mode = .work
    @State private var timeRemaining: Int = 120
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        VStack {
            Divider()
            Spacer()
            Text(mode == .stopped ? "Paused" : "Work")
                .font(Font.system(size: 60, weight: .semibold, design: .default))
                .foregroundColor(.white)
            Spacer()
            CountdownText(text: timeRemaining.timeDisplay())
            Spacer()
            Button {
                startPressed()
            } label: {
                Text(mode == .stopped ? "Start" : "Pause")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .frame(width: 100, height: 100, alignment: .center)
            .background(.yellow)
            .cornerRadius(50)
            Spacer()
                
        }
        .background(Color(UIColor.darkGray))
        .onReceive(timer) { time in
            if timeRemaining > 0 && mode != .stopped{
                timeRemaining -= 1
            }
        }

    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}

struct CountdownText: View {
    var text: String
    var body: some View {
        Text(text)
            .font(Font.system(size: 120, weight: .bold, design: .default))
            .fontWeight(.bold)
            .padding()
            .foregroundColor(.white)
    }
}



extension Int {
    func timeDisplay() -> String {
        let minutes = Int(Double(self)/60.0)
        var seconds = String(self % 60)
        if seconds.count == 1 {
            seconds = "0" + seconds
        }
        return String(minutes) + ":" + seconds
    }
}

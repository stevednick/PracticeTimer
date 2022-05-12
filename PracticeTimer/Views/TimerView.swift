//
//  ContentView.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 30/04/2022.
//

import SwiftUI

struct TimerView: View {
    
    @ObservedObject var controller: Controller = Controller()
    
    init() {
        UINavigationBar.setAnimationsEnabled(false)
    }
    
    var body: some View {
        NavigationView {
            MainView(controller: controller)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainView: View {
    
    @State private var isPaused = false
    
    @ObservedObject var controller: Controller
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(controller: Controller) {
        self.controller = controller
    }
    
    var body: some View {

        VStack {
            NavigationLink(destination: PauseView(controller: controller), isActive: $controller.isPaused) { EmptyView() }
            Spacer()
            HStack{
                NavigationLink(destination: SettingsView(controller: controller)) {
                    Text("Settings")
                        .font(Font.system(size: 25, weight: .semibold, design: .default))
                }
                .padding(.leading, 40.0)
                .frame(height: 20.0)
                .isHidden(![Mode.finished, Mode.waitingToStart].contains(controller.currentState))
                Spacer()
            }
            Divider()
            Group{
                Spacer()
                Text(controller.stateText)
                    .font(Font.system(size: 60, weight: .semibold, design: .default))
                    .foregroundColor(.white)
                Spacer()
                CountdownText(text: controller.timeRemaining.timeDisplay())
                Spacer()
                ButtonView(functionToRun: controller.startButtonPressed, text: controller.startButtonText, colour: controller.currentState == Mode.waitingToStart ? Color.appGreen: Color.appLightOrange)
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .navigationBarTitle(Text("Home"))
        .edgesIgnoringSafeArea([.top, .bottom])
        .background(Color(UIColor.darkGray))
        .onReceive(timer) { time in
            controller.incrementTime()
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
            //.previewDevice("iPad Pro (12.9-inch) (5th generation)")
        //SettingsView(controller: Controller())
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

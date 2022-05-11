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
        //UINavigationBar.setAnimationsEnabled(false)
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
                ButtonView(functionToRun: controller.startButtonPressed, text: controller.startButtonText, colour: controller.currentState == Mode.waitingToStart ? Color.buttonGreen: Color.buttonOrange)
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

struct SettingsView: View {
    
    @ObservedObject var controller: Controller
    @State var workSliderValue: Double
    @State var restSliderValue: Double
    
    init(controller: Controller) {
        self.controller = controller
        workSliderValue = Double(controller.workDuration)
        restSliderValue = Double(controller.restDuration)
    }
    var body: some View {
        ZStack{
            VStack{
                Divider()
                Spacer()
                SettingsSlider(text: "No. of Reps", sliderValue: Double(controller.reps), minValue: 1, maxValue: 15, controller: controller, sliderNumber: 0)
                Spacer()
                SettingsSlider(text: "Work Duration", sliderValue: Double(controller.workDuration), minValue: 30, maxValue: 1500, controller: controller, sliderNumber: 2)
                Spacer()
                SettingsSlider(text: "Rest Duration", sliderValue: Double(controller.restDuration), minValue: 10, maxValue: 300, controller: controller, sliderNumber: 1)
                Spacer()

            }
            .background(Color(UIColor.darkGray))
        }
        .onDisappear {
            controller.saveSettings()
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

struct SettingsSlider: View {
    var text: String
    @State var sliderValue: Double
    var minValue: Double
    var maxValue: Double
    @ObservedObject var controller: Controller
    var sliderNumber: Int
    
    var body: some View {
        VStack {
            Text(text)
                .font(Font.system(size: 30, weight: .bold, design: .default))
                .foregroundColor(.white)
            Slider(value:
                    $sliderValue, in: minValue...maxValue, step: sliderNumber == 0 ? 1 : 5) { changed in
                switch sliderNumber {
                case 0:
                    controller.reps = Int(sliderValue)
                case 1:
                    controller.restDuration = Int(sliderValue)
                default:
                    controller.workDuration = Int(sliderValue)
                }
            }
            Text(sliderNumber == 0 ? "\(Int(sliderValue))" : "\(Int(sliderValue).timeDisplay())")
                .font(Font.system(size: 40, weight: .bold, design: .default))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 20)
    }
}


struct ButtonView: View {
    
    var functionToRun: () -> Void
    var text: String
    var colour: Color
    
    var body: some View {
        Button {
            functionToRun()
        } label: {
            Text(text)
                .font(Font.system(size: 18, weight: .semibold, design: .default))
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .frame(width: 100, height: 100, alignment: .center)
        .background(colour)
        .cornerRadius(50)
    }
}

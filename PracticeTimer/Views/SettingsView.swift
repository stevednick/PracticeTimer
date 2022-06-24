//
//  SettingsView.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 11/05/2022.
//

import SwiftUI


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
                Text(controller.scheduleMode ? "Schedule Mode" : "Simple Mode")
                    .font(.system(size: 25, weight: .semibold, design: .default))
                    .foregroundColor(.blue)
                    .onTapGesture {
                        controller.toggleScheduleMode()
                    }
                    .padding(.vertical, 10.0)
                Spacer()
                SettingsSlider(text: "No. of Reps", sliderValue: Double(controller.reps), minValue: 1, maxValue: 15, controller: controller, sliderNumber: 0, colour: .appOrange)
                    .opacity(controller.scheduleMode ? 0.5 : 1)
                Spacer()
                SettingsSlider(text: "Work Duration", sliderValue: workSliderValue, minValue: 1, maxValue: 45, controller: controller, sliderNumber: 2, colour: .appGreen)
                Spacer()
                SettingsSlider(text: "Rest Duration", sliderValue: restSliderValue, minValue: 1, maxValue: 38, controller: controller, sliderNumber: 1, colour: .appBlue)
                Spacer()

            }
        }
        .onDisappear {
            controller.saveSettings()
        }
    }
}

struct SettingsSlider: View {
    
    var text: String
    @State var sliderValue: Double
    var minValue: Double
    var maxValue: Double
    @ObservedObject var controller: Controller
    var sliderNumber: Int
    var colour: Color
    
    var body: some View {
        VStack {
            Text(text)
                .font(Font.system(size: 30, weight: .bold, design: .default))
            Slider(value:
                    $sliderValue, in: minValue...maxValue, step: 1) { changed in
                switch sliderNumber {
                case 0:
                    controller.reps = Int(sliderValue)
                case 1:
                    controller.restDuration = Int(sliderValue)
                default:
                    controller.workDuration = Int(sliderValue)
                }
            }
                    .tint(colour)
            Text(sliderNumber == 0 ? "\(Int(sliderValue))" : "\(Tools.timerValues[Int(sliderValue)].timeDisplay())")
                .font(Font.system(size: 40, weight: .bold, design: .default))
        }
        .padding(.horizontal, 20)
        .onDisappear {
            controller.setTimeToDisplay()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(controller: Controller())
    }
}

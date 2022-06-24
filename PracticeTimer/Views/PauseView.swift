//
//  PauseView.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 08/05/2022.
//

import SwiftUI

struct PauseView: View {
    
    @ObservedObject var controller: Controller
    
    init(controller: Controller) {
        self.controller = controller
    }
    
    var body: some View{
        VStack{
            Divider()
            Group {
                Spacer()
                Text(controller.pausedStateText)
                    .font(Font.system(size: 50, weight: .semibold, design: .default))
                Spacer()
                Text(controller.timeRemaining.timeDisplay())
                    .font(Font.system(size: 45, weight: .semibold, design: .default))
                Spacer()
                Text("Paused")
                    .font(Font.system(size: 70, weight: .bold, design: .default))
                Spacer()
            }
            Group {
                ButtonView(functionToRun: controller.endButtonPressed, text: "Finish", colour: Color.appOrange)
                Spacer()
                ButtonView(functionToRun: controller.startButtonPressed, text: "Continue", colour: Color.appGreen)
                Spacer()
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
        
}

struct PauseView_Previews: PreviewProvider {
    static var previews: some View {
        PauseView(controller: Controller())
    }
}

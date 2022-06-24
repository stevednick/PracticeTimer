//
//  MainView.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 21/06/2022.
//

import SwiftUI


struct MainView: View {
    
    @State private var isPaused = false
    
    @EnvironmentObject var realmManager: RealmManager
    @StateObject var controller: Controller = Controller()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {

        VStack {
            NavigationLink(destination: PauseView(controller: controller), isActive: $controller.isPaused) { EmptyView() }
            Group{
                Text("Session \(controller.currentPosition[0] + 1)")
                    .font(.system(size: 30, weight: .semibold, design: .default))
                    .foregroundColor(.blue)
                    .onTapGesture {
                        _ = controller.incrementPosition(nextSession: true)
                    }
                    .padding(.bottom, 10.0)
                    .isHidden(!controller.scheduleMode)
            }
            Spacer()
            Group{
                Text(controller.stateText)
                    .font(Font.system(size: 54, weight: .semibold, design: .default))
                Spacer()
                CountdownText(text: controller.timeRemaining.timeDisplay())
                Spacer()
                ButtonView(functionToRun: controller.startButtonPressed, text: controller.startButtonText, colour: controller.currentState == Mode.waitingToStart ? Color.appGreen: Color.appLightOrange)
                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading:
            NavigationLink(destination: SettingsView(controller: controller)) {
            Text("Settings")
                .isHidden(![Mode.finished, Mode.waitingToStart].contains(controller.currentState))
        },
            trailing:
                NavigationLink(destination:
                                ScheduleView(controller: self.controller)
                         .environmentObject(self.realmManager))
                    {
                     Text("Schedule")
                         .isHidden(![Mode.finished, Mode.waitingToStart].contains(controller.currentState))
                 }
            )
        .onReceive(timer) { time in
            controller.incrementTime()
        }
        .onAppear {
            UIApplication.shared.isIdleTimerDisabled = true
            controller.schedule = realmManager.schedule
        }
        .onDisappear { UIApplication.shared.isIdleTimerDisabled = false
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(RealmManager())
    }
}

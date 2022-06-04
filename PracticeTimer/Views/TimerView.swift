//
//  ContentView.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 30/04/2022.
//

import SwiftUI
import CoreData

struct TimerView: View {
    
    @StateObject var controller: Controller = Controller()
    @StateObject var activityContolller: ActivityController = ActivityController()
    
    init() {
        UINavigationBar.setAnimationsEnabled(false)
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                MainView(controller: controller, activityController: activityContolller)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainView: View {
    
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Interval.entity(), sortDescriptors: []) var intervals: FetchedResults<Interval>
    @FetchRequest(entity: Schedule.entity(), sortDescriptors: []) var schedule: FetchedResults<Schedule>
    
    @State private var isPaused = false
    
    @ObservedObject var controller: Controller
    @ObservedObject var activityController: ActivityController
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(controller: Controller, activityController: ActivityController) {
        self.controller = controller
        self.activityController = activityController
    }
    
    var body: some View {

        VStack {
            NavigationLink(destination: PauseView(controller: controller), isActive: $controller.isPaused) { EmptyView() }
            Spacer()
            HStack{
                NavigationLink(destination: SettingsView(controller: controller, activityController: activityController)) {
                    Text("Settings")
                        .font(Font.system(size: 25, weight: .semibold, design: .default))
                }
                .padding(.leading, 40.0)
                .frame(height: 20.0)
                Spacer()
                NavigationLink(destination: ActivityView(activityController: activityController)) {
                               
                    //ScheduleView()) {
                    Text("Intervals")
                        .font(Font.system(size: 25, weight: .semibold, design: .default))
                }
                .padding(.trailing, 40.0)
                .frame(height: 20.0)
            }
            .isHidden(![Mode.finished, Mode.waitingToStart].contains(controller.currentState))
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
        .onAppear { UIApplication.shared.isIdleTimerDisabled = true }
        .onDisappear { UIApplication.shared.isIdleTimerDisabled = false }
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

extension MainView {
    func saveContext() {
        do {
            try context.save()
            DispatchQueue.main.async {
                //
            }
        }catch {
            print(error)
        }
        print("Context Saved")
    }
}

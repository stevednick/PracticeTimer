//
//  PracticeTimerApp.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 30/04/2022.
//

import SwiftUI

@main
struct PracticeTimerApp: App {
    
    //@StateObject private var dataController = DataController()
    let context = DataStore.shared.persistentContainer.viewContext
    var body: some Scene {
        WindowGroup {
            TimerView()
                .environment(\.managedObjectContext, context)
        }
    }
}

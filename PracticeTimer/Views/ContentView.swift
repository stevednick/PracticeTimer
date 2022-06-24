//
//  ContentView.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 30/04/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var realmManager = RealmManager()
    
    init() {
        UINavigationBar.setAnimationsEnabled(false)
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                MainView()
                    .environmentObject(self.realmManager)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            //.previewDevice("iPad Pro (12.9-inch) (5th generation)")
        //SettingsView(controller: Controller())
    }
}


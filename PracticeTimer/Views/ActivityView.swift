//
//  ActivityView.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 12/05/2022.
//

import SwiftUI

struct ActivityView: View{
    
    @ObservedObject var activityController: ActivityController
    @EnvironmentObject var realmManager: RealmManager

    @State var isPresented = false
    
    
    var body: some View {
        VStack{
            
        }
        //.sheet(isPresented: $isPresented) {
//          AddInterval { name, volume, tempo, articulation in
//              dataView.addInterval(name: name, volume: volume, tempo: tempo, articulation: articulation)
//            self.isPresented = false
           
//        .navigationBarTitle(Text("Intervals"))
//          .navigationBarItems(trailing:
//            Button(action: { self.isPresented.toggle() }) {
//              Image(systemName: "plus")
//            }
//        )
    
    }
    
    func testSchedule() {
//        let schedule = Schedule(context: context)
//        schedule.list = [[1, 4, 6], [5, 2, 6], [4, 7, 9]]
//        dataView.saveContext()
    }
    
    func getSchedule() {
//        print(schedule[0].list?[1][2] ?? 0)
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(activityController: ActivityController())
            .environmentObject(RealmManager())
    }
}

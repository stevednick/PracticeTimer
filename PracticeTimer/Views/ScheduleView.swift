//
//  ScheduleView.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 21/05/2022.
//

import SwiftUI

struct ScheduleView: View {
    
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Interval.entity(), sortDescriptors: []) var intervals: FetchedResults<Interval>
    @FetchRequest(entity: Schedule.entity(), sortDescriptors: []) var schedule: FetchedResults<Schedule>
    @State var sessionData: [[Int]] = [[]]

    
    var body: some View {
        VStack{
            Text("Schedule View")
            ForEach(sessionData, id: \.self) { session in
                ForEach(session, id: \.self) { slot in
                    let text = String(slot)
                    Text(text)
                }
                .onMove(perform: move)
             }
            .toolbar {
                EditButton()
            }
        }
        .onAppear(){
            sessionData = schedule[0].list ?? [[0]]
            print(sessionData)
            print("Runs")
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        //
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}

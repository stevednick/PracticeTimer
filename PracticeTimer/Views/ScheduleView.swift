//
//  ScheduleView.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 21/05/2022.
//

import SwiftUI

struct ScheduleView: View {
    
    @EnvironmentObject var realmManager: RealmManager
    @State var isPresented: Bool = false
    var clickedSlot: [Int] = [0, 0]
    
    var body: some View {
        VStack{
            Text("\(realmManager.schedule.count)")
            HStack{
                Text("Schedule View")
                Button {
                    self.realmManager.addSession()
                } label: {
                    Text("Add Session")
                }
            }
            List{
                ForEach(0..<realmManager.schedule.count, id: \.self) { sessionNumber in
                    SessionRow(sessionNumber: sessionNumber, session: realmManager.schedule[sessionNumber])
                }
            }
            .toolbar {
                EditButton()
            }
        }
        .sheet(isPresented: $isPresented) {
                  AddInterval { name, volume, tempo, articulation in
                      self.realmManager.updateSlot(session: clickedSlot[0], position: clickedSlot[1], interval: Interval(value: ["title": name]))
                    self.isPresented = false
            }
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        //
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
            .environmentObject(RealmManager())
    }
}

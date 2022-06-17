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
    @State var clickedSlot: [Int] = [0, 0]
    @State var refreshToggle = false
    
    var body: some View {
        VStack{
            HStack{
                Text("Schedule View")
                Button {
                    realmManager.addSession()
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
        }.sheet(isPresented: $isPresented) {
                  AddInterval { name, volume, tempo, articulation in
                      realmManager.updateSlot(session: clickedSlot[0], position: clickedSlot[1], interval: Interval(value: ["title": name]))
                    self.isPresented = false
            }
        }
    }
    
    func deleteSession(at offsets: IndexSet){
        realmManager.deleteSession(sessionNumber: Int(offsets.first ?? 0))
    }
    func reloadSlots() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            refreshToggle.toggle()
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

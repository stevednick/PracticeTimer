//
//  ScheduleView.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 21/05/2022.
//

import SwiftUI

struct ScheduleView: View {
    
    @EnvironmentObject var realmManager: RealmManager
    var clickedSlot: [Int] = [0, 0]
    var controller: Controller
    
    var body: some View {
        VStack{
            List{
                ForEach(0..<realmManager.schedule.count, id: \.self) { sessionNumber in
                    Section{
                        SessionRow(sessionNumber: sessionNumber, session: realmManager.schedule[sessionNumber])
                    }
                }
            }
        }
        .navigationBarTitle(Text("Schedule"))
        .navigationBarItems(trailing: Button(action: { realmManager.addSession() }) {
            Text("Add Session")
            }
        )
        .onAppear{
            _ = controller.incrementPosition(reset: true)
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        //
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView(controller: Controller())
            .environmentObject(RealmManager())
    }
}

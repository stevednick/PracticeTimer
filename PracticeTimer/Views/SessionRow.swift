//
//  SessionRow.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 17/06/2022.
//

import SwiftUI

struct SessionRow: View {
    @EnvironmentObject var realmManager: RealmManager
    var sessionNumber: Int
    var session: [Slot]
    
    var body: some View {
        VStack{
            HStack{
                Text("Session \(sessionNumber + 1)")
                Button {
                    self.realmManager.deleteSession(sessionNumber: sessionNumber)
                } label: {
                    Label("", systemImage: "trash")
                }
                .buttonStyle(PlainButtonStyle())
                Button {
                    self.realmManager.addSlot(sessionNumber: sessionNumber)
                } label: {
                    Label("", systemImage: "plus")
                }
                .buttonStyle(PlainButtonStyle())
            }
            ForEach(0..<self.session.count, id: \.self) { slotNumber in
                SlotRow(slot: self.session[slotNumber], ownPosition: [self.sessionNumber, slotNumber])
            }
            .onDelete { indexSet in
                //
            }
        }
        .onAppear{
            print("Session Number: \(sessionNumber) loaded.")
        }
    }
}

struct SessionRow_Previews: PreviewProvider {
    static var previews: some View {
        SessionRow(sessionNumber: 0, session: RealmManager().schedule[0])
            .environmentObject(RealmManager())
    }
}


//
//  SessionRow.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 17/06/2022.
//

import SwiftUI

struct SessionRow: View {
    @EnvironmentObject var realmManager: RealmManager
    @State var sessionNumber: Int
    @State var session: [Slot]
    var body: some View {
        VStack{
            HStack{
                Text("Session \(sessionNumber + 1)")
                Button {
                    realmManager.deleteSession(sessionNumber: sessionNumber)
                } label: {
                    Label("", systemImage: "trash")
                }
                .buttonStyle(PlainButtonStyle())
                Button {
                    realmManager.addSlot(sessionNumber: sessionNumber)
                } label: {
                    Label("", systemImage: "plus")
                }
                .buttonStyle(PlainButtonStyle())
            }
            ForEach(0..<session.count, id: \.self) { slotNumber in
                SlotRow(slot: session[slotNumber], ownPosition: [sessionNumber, slotNumber])
                    .environmentObject(realmManager)
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


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
            HStack(alignment: .top){
                Text("Session \(sessionNumber + 1)")
                    .font(.title)
                Spacer()
                Text("Add Interval")
                    .foregroundColor(.blue)
                    .onTapGesture {
                        self.realmManager.addSlot(sessionNumber: sessionNumber)
                    }
                .padding(.trailing)
                Button {
                    self.realmManager.deleteSession(sessionNumber: sessionNumber)
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(.textColour)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.top, 10.0)
            .padding(.bottom, 30.0)

            ForEach(0..<self.session.count, id: \.self) { slotNumber in
                Divider()
                SlotRow(slot: self.session[slotNumber], ownPosition: [self.sessionNumber, slotNumber], deleteSlot: {deleteSlot(session: sessionNumber, position: slotNumber)})
            }
        }
    }
    
    func deleteSlot(session: Int, position: Int) {
        realmManager.deleteSlot(sessionNumber: session, position: position)
    }
}

struct SessionRow_Previews: PreviewProvider {
    static var previews: some View {
        SessionRow(sessionNumber: 0, session: RealmManager().schedule[0])
            .environmentObject(RealmManager())
    }
}


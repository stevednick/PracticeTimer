//
//  SlotCardView.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 09/06/2022.
//

import SwiftUI

struct SlotRow: View {
    
    @EnvironmentObject var realmManager: RealmManager
    var slot: Slot
    var ownPosition: [Int]
    var deleteSlot: () -> Void
    @State var isPresented = false
    
    var body: some View {
        VStack{
            HStack(spacing: 10){
                Text(slot.text)
                Spacer()
                Button {
                    if slot.interval == nil {
                        self.isPresented = true
                    } else {
                        self.realmManager.updateSlot(session: ownPosition[0], position: ownPosition[1], interval: nil)
                    }
                } label: {
                    Image(systemName: slot.interval == nil ? "plus" : "multiply")
                        .foregroundColor(slot.interval == nil ? .green : .red)
                }
                .buttonStyle(PlainButtonStyle())
                Button {
                    self.deleteSlot()
                } label: {
                    Image(systemName: "trash")
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.vertical, 10.0)
        }
        .sheet(isPresented: $isPresented) {
                  AddInterval { name, volume, tempo, articulation in
                      self.realmManager.updateSlot(session: ownPosition[0], position: ownPosition[1], interval: Interval(value: ["title": name]))
                    self.isPresented = false
            }
        }
    }
    
    func deleteIntervalFromSlot() {
        realmManager.updateSlot(session: ownPosition[0], position: ownPosition[1], interval: nil)
    }

}

struct SlotRow_Previews: PreviewProvider {
    static var previews: some View {
        SlotRow(slot: Slot(), ownPosition: [0, 0], deleteSlot: {})
            .environmentObject(RealmManager())
    }
}

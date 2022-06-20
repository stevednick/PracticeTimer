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
    
    var body: some View {
        VStack{
            HStack{
                Text(slot.text)
            }
        }
        .padding()
        .frame(height: 80.0)
        .onAppear{
            print("Slot \(ownPosition) loaded.")
        }
    }
    
    func deleteIntervalFromSlot() {
        realmManager.updateSlot(session: ownPosition[0], position: ownPosition[1], interval: nil)
    }

}

//struct SlotRow_Previews: PreviewProvider {
//    static var previews: some View {
//        SlotRow(slot: Slot(value: ["interval": Interval(value: ["title" : "Mahler"])]), isPresented: ScheduleView().$isPresented, slotPosition: ScheduleView().$clickedSlot, ownPosition: [0,0])
//            .environmentObject(RealmManager())
//    }
//}

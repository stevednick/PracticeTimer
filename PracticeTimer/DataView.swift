//
//  DataView.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 01/06/2022.
//

import SwiftUI

struct DataView: View{
    
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Interval.entity(), sortDescriptors: []) var intervals: FetchedResults<Interval>
    @FetchRequest(entity: Schedule.entity(), sortDescriptors: []) var schedule: FetchedResults<Schedule>
    
    func saveContext() {
        do {
            try context.save()
//            DispatchQueue.main.async {
//                //
//            }
        }catch {
            print(error)
        }
        print("Context Saved")
    }
    
    func addInterval(name: String, volume: Int, tempo: Int, articulation: Int) {
      // 1
        let interval = Interval(context: context)

        interval.name = name
        interval.volume = Int16(volume)
        interval.tempo = Int16(tempo)
        interval.articulation = Int16(articulation)
      // 3
        saveContext()
    }
    
    func deleteInterval(at offsets: IndexSet) {
      // 1
      offsets.forEach { index in
        // 2
        let interval = self.intervals[index]
        // 3
        self.context.delete(interval)
      }
      // 4
        saveContext()
    }
    
    var body: some View {
        Text("")
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView()
    }
}

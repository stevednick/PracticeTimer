//
//  ActivityView.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 12/05/2022.
//

import SwiftUI

struct ActivityView: View {
    
    @ObservedObject var activityController: ActivityController
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Interval.entity(), sortDescriptors: []) var intervals: FetchedResults<Interval>
    
    @State var isPresented = false
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(intervals, id: \.name) {
                  IntervalRow(interval: $0)
                }
                .onDelete(perform: deleteInterval)
            }
            .sheet(isPresented: $isPresented) {
              AddInterval { name, volume, tempo, articulation in
                  self.addInterval(name: name, volume: volume, tempo: tempo, articulation: articulation)
                self.isPresented = false
              }
            }

            .navigationBarTitle(Text("Intervals"))
              .navigationBarItems(trailing:
                Button(action: { self.isPresented.toggle() }) {
                  Image(systemName: "plus")
                }
            )
        }
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
    func saveContext() {
        do {
            try context.save()
            DispatchQueue.main.async {
                //
            }
        }catch {
            print(error)
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(activityController: ActivityController())
    }
}

//
//  AddInterval.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 18/05/2022.
//

import SwiftUI

struct AddInterval: View {

    @State var name = ""
    @State var genre = ""
    @State private var volume: Int = 1
    @State private var tempo: Int = 1
    @State private var articulation: Int = 1
    let onComplete: (String, Int, Int, Int) -> Void

  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Name")) {
          TextField("New Activity", text: $name)
        }
          Section{
              Picker(selection: $volume, label: Text("Volume")) {
                  Text("Quiet").tag(0)
                  Text("Medium").tag(1)
                  Text("Loud").tag(2)
              }
          }
          Section{
              Picker(selection: $tempo, label: Text("Tempo")) {
                  Text("Slow").tag(0)
                  Text("Medium").tag(1)
                  Text("Fast").tag(2)
              }
          }
          Section{
              Picker(selection: $articulation, label: Text("Articulation")) {
                  Text("Legato").tag(0)
                  Text("Neutral").tag(1)
                  Text("Staccato").tag(2)
              }
          }
        Section {
          Button(action: addMoveAction) {
            Text("Add Interval")
          }
        }
      }
      .navigationBarTitle(Text("Add Activity"), displayMode: .inline)
    }
  }

  private func addMoveAction() {
    onComplete(
      name.isEmpty ? "Interval" : name,
      volume,
      tempo,
      articulation
    )
  }
}

enum Volume: String, CaseIterable, Identifiable {
    case quiet, medium, loud
    var id: Self { self }
}

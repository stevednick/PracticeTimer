//
//  IntervalRow.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 18/05/2022.
//

import SwiftUI

    struct IntervalRow: View {
        let interval: Interval
        let volumes: [String] = ["Quiet", "No Dynamic", "Loud"]
        let tempos: [String] = ["Slow", "No Tempo", "Fast"]
        let articulations: [String] = ["Legato", "No Articulation", "Staccato"]

        var body: some View {
            VStack(alignment: .leading) {
            interval.name.map(Text.init)
                .font(.title)
            HStack {
                Text(volumes[Int(interval.volume)])
                    .font(.caption)
                Spacer()
                Text(tempos[Int(interval.tempo)])
                    .font(.caption)
                Spacer()
                Text(articulations[Int(interval.articulation)])
                    .font(.caption)
            }
        }
    }

}

//
//  IntervalRow.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 18/05/2022.
//

import SwiftUI

    struct IntervalRowOld: View {
        
        var save: () -> Void
        //@State var interval: Interval
//        let volumes: [String] = ["Quiet", "No Dynamic", "Loud"]
//        let tempos: [String] = ["Slow", "No Tempo", "Fast"]
//        let articulations: [String] = ["Legato", "No Articulation", "Staccato"]

        var body: some View {
            VStack() {
//                HStack{
//                    interval.name.map(Text.init)
//                        .font(.title)
//                        .padding([.leading, .bottom], 5.0)
//                        .foregroundColor(interval.on ? .black : Color(UIColor.lightGray))
//                    Spacer()
//                    Button { // fix full button click thing?
//                        interval.on = !interval.on
//                        self.save()
//                    } label: {
//                        Text(interval.on ? "Disable" : "Enable")
//                    }
//                    .buttonStyle(PlainButtonStyle())
//                    .foregroundColor(.blue)
//                }
//            HStack {
//                Text(volumes[Int(interval.volume)])
//                    .modifier(AttributeText(on: interval.on))
//                Spacer()
//                Text(tempos[Int(interval.tempo)])
//                    .modifier(AttributeText(on: interval.on))
//                Spacer()
//                Text(articulations[Int(interval.articulation)])
//                    .modifier(AttributeText(on: interval.on))
//            }
        }
    }
}

struct AttributeText: ViewModifier {
    var on: Bool
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            .foregroundColor(on ? .black : Color(UIColor.lightGray))
    }
}

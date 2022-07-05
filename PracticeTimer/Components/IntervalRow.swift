//
//  IntervalRow.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 05/07/2022.
//

import SwiftUI

struct IntervalRow: View {
    var interval: Interval
    var body: some View {
        Text(interval.title)
    }
}

struct IntervalRow_Previews: PreviewProvider {
    static var previews: some View {
        IntervalRow(interval: Interval(value: ["title": "Test"]))
    }
}

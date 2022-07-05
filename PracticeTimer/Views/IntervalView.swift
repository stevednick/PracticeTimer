//
//  IntervalView.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 05/07/2022.
//

import SwiftUI

struct IntervalView: View {
    @EnvironmentObject var realmManager: RealmManager
    var body: some View {
        VStack{
            List{
                ForEach(0..<realmManager.intervals.count, id: \.self){ intervalNumber in
                    IntervalRow(interval: realmManager.intervals[intervalNumber])
                }
            }
        }
    }
}

struct IntervalView_Previews: PreviewProvider {
    static var previews: some View {
        IntervalView()
            .environmentObject(RealmManager())
    }
}

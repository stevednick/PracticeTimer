//
//  ActivityView.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 12/05/2022.
//

import SwiftUI

struct ActivityView: View {
    @ObservedObject var activityController: ActivityController
    
    var body: some View {
        ScrollView{
            VStack {
                ForEach(0..<activityController.numberOfActivities, id: \.self) { i in
                    ActivityCardView(activityController: activityController, number: i)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color(UIColor.darkGray))
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(activityController: ActivityController())
    }
}

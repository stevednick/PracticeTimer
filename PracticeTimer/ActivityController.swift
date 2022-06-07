//
//  Activities.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 12/05/2022.
//

import CoreData
import SwiftUI

struct Activity: Identifiable { // Transfer all this stuff into Interval
    var id = UUID()
    var number: Int
    var name: String = ""
    var volume: Int = 1
    var articulation: Int = 1
    var tempo: Int = 1
}

class ActivityController: ObservableObject {
    
    
    let defaults = UserDefaults.standard
    var activities: [Activity] = []
    var numberOfActivities: Int
    
    init() {
        numberOfActivities = defaults.integer(forKey: "reps")
        for i in 0..<numberOfActivities {
            activities.append(Activity(number: i))
        }
        //activities = [Activity](repeating: Activity(), count: numberOfActivities)
    }
    
    func numberOfActivitiesChanged(){
        activities = []
        numberOfActivities = defaults.integer(forKey: "reps")
        for i in 0..<numberOfActivities {
            activities.append(Activity(number: i))
        }
    }

    func newInterval() {

    }
}

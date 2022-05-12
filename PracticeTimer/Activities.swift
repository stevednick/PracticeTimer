//
//  Activities.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 12/05/2022.
//

import SwiftUI

struct Activity {
    var name: String = "New Activity"
    var volume: Int = 1
    var articulation: Int = 1
    var tempo: Int = 1
}

struct ActivityController {
    
    var activities: [Activity] = []
    
    mutating func newActivity() {
        activities.append(Activity())
    }
}

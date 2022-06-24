//
//  tools.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 10/05/2022.
//

import SwiftUI

extension Color {
    static let buttonGreen = Color("lightGreen")
    static let buttonOrange = Color("lightOrange")
    static let buttonRed = Color("buttonRed")
    static let vLightGrey = Color("veryLightGrey")
    static let appOrange = Color("appOrange")
    static let appGreen = Color("appGreen")
    static let appBlue = Color("appBlue")
    static let appLightOrange = Color("appLightOrange")
    static let appYellow = Color("appYellow")
    static let textColour = Color("textColour")
    static let backgroundColour = Color("backgroundColour")
}

extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}

extension Int {
    func timeDisplay() -> String {
        let minutes = Int(Double(self)/60.0)
        var seconds = String(self % 60)
        if seconds.count == 1 {
            seconds = "0" + seconds
        }
        return String(minutes) + ":" + seconds
    }
}

struct Tools {
    
    public static let timerValues: [Int] = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 195, 210, 225, 240, 260, 280, 300, 320, 340, 360, 390, 420, 450, 480, 510, 540, 570, 600, 660, 720, 780, 840, 900]
}

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
}

extension View {
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    ///
    ///     Text("Label")
    ///         .isHidden(true)
    ///
    /// Example for complete removal:
    ///
    ///     Text("Label")
    ///         .isHidden(true, remove: true)
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
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

struct Tools {
    public static let timerValues: [Int] = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 195, 210, 225, 240, 260, 280, 300, 320, 340, 360, 390, 420, 450, 480, 510, 540, 570, 600, 660, 720, 780, 840, 900]
}

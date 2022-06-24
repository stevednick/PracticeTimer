//
//  Components.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 11/05/2022.
//

import SwiftUI

struct ButtonView: View {
    
    var functionToRun: () -> Void
    var text: String
    var colour: Color
    
    var body: some View {
        Button {
            functionToRun()
        } label: {
            Text(text)
                .font(Font.system(size: 18, weight: .semibold, design: .default))
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .frame(width: 100, height: 100, alignment: .center)
        .background(colour)
        .cornerRadius(50)
    }
}

struct CountdownText: View {
    var text: String
    var body: some View {
        Text(text)
            .font(Font.system(size: 120, weight: .bold, design: .default))
            .fontWeight(.bold)
            .padding()
            .foregroundColor(.textColour)
    }
}


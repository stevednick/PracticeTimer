//
//  ActivityCardView.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 11/05/2022.
//

import SwiftUI

struct ActivityCardView: View {
    
    let articulations: [String] = ["Legato", "Neutral", "Staccato"]
    let speeds: [String] = ["Adagio", "Moderato", "Vivace"]
    let volumes: [String] = ["pp", "mf", "ff"]
    
    @State var activityName: String
    @State var speed: Int
    @State var articulation: Int
    @State var volume: Int
    
    var body: some View {
        
        VStack{
            TextField(activityName, text: $activityName)
                .multilineTextAlignment(.center)
                .font(Font.system(size: 40, weight: .semibold, design: .default))
                .padding(.top, 20.0)
                .foregroundColor(Color(UIColor.darkGray))
            Spacer()
            HStack{
                Button {
                    volume = volume == 2 ? 0 : volume + 1
                } label: {
                    Text(volumes[volume])
                }
                Spacer()
                Button {
                    speed = speed == 2 ? 0 : speed + 1
                } label: {
                    Text(speeds[speed])
                }
                Spacer()
                Button {
                    articulation = articulation == 2 ? 0 : articulation + 1
                } label: {
                    Text(articulations[articulation])
                }
            }
            .padding([.leading, .bottom, .trailing], 25.0)
        }
        .frame(height: 140.0)
        .background(Color.vLightGrey)
        .cornerRadius(10)
        .padding()
    }
}

struct ActivityCardView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityCardView(activityName: "Mahler", speed: 2, articulation: 0, volume: 1)
            .previewLayout(.fixed(width: 390, height: 170))
            .background(Color(UIColor.darkGray))
    }
}


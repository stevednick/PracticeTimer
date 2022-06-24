//
//  ActivityCardView.swift
//  PracticeTimer
//
//  Created by Stephen Nicholls on 11/05/2022.
//

import SwiftUI

struct ActivityCardView: View { // Send activitycontroller so you can save activity when changed?
    
    let articulations: [String] = ["Legato", "Neutral", "Staccato"]
    let speeds: [String] = ["Adagio", "Moderato", "Vivace"]
    let volumes: [String] = ["pp", "mf", "ff"]
    
    var number: Int
    
    var body: some View {
        Text("")
//        VStack{
//            TextField(activityController.activities[number].name == "" ? "Interval \(number + 1)" : activityController.activities[number].name, text: $activityController.activities[number].name)
//                .multilineTextAlignment(.center)
//                .font(Font.system(size: 40, weight: .semibold, design: .default))
//                .padding(.top, 15.0)
//                .foregroundColor(Color(UIColor.darkGray))
//            Spacer()
//            HStack{
//                AttributeButton(activityController: activityController, number: number, attribute: 0, attributeList: volumes, value: activityController.activities[number].volume)
//                AttributeButton(activityController: activityController, number: number, attribute: 1, attributeList: speeds, value: activityController.activities[number].tempo)
//                AttributeButton(activityController: activityController, number: number, attribute: 2, attributeList: articulations, value: activityController.activities[number].articulation)
//            }
//            .padding(.bottom, 20.0)
//        }
//        .frame(maxWidth: .infinity, maxHeight: 120.0)
//        .background(Color.vLightGrey)
//        .cornerRadius(6)
//        .padding(.horizontal)
        
    }
}

struct ActivityCardView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityCardView(number: 0)
            //.previewLayout(.fixed(width: 390, height: 150))
            //.background(Color(UIColor.darkGray))
    }
}


struct AttributeButton: View {
    
    var number: Int
    var attribute: Int
    //@Binding var attribute: Int
    var attributeList: [String]
    @State var value: Int
    
    init(number: Int, attribute: Int, attributeList: [String], value: Int) {
        self.number = number
        self.attribute = attribute
        self.attributeList = attributeList
        self.value = value
    }
    
    var body: some View {
        Button {
//            value = value == 2 ? 0 : value + 1
//            if number == 0 {
//                activityController.activities[number].volume = value
//            } else if number == 1 {
//                activityController.activities[number].tempo = value
//            } else {
//                activityController.activities[number].articulation = value
//            }
        } label: {
            Text(attributeList[value])
                .font(Font.system(size: 20, weight: .bold, design: .default))
                .foregroundColor(value == 0 ? .appGreen : value == 1 ? .appBlue : .appOrange)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

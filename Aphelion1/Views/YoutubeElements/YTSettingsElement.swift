//
//  YTSettingsElement.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/15.
//

import SwiftUI

struct YTSettingsElement: View {
    
    var fontSize: CGFloat
    var stepperWidth: CGFloat
    var stepperHeight: CGFloat
    var spacing: CGFloat
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        ZStack {
            
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Difficulty")
                        .font(Font.system(size: fontSize))
                    Spacer()
                    Text("Tile Speed")
                        .font(Font.system(size: fontSize))
                    Spacer()
                    Text("Animation")
                        .font(Font.system(size: fontSize))
                    Spacer()
                    Text("Background")
                        .font(Font.system(size: fontSize))
                }
                Spacer()
            }
            .frame(height: height)
            
            
            VStack {
                DifficultyButton(fontSize: fontSize)
                Spacer()
                TileSpeedStepper(width: stepperWidth, height: stepperHeight, spacing: spacing)
                Spacer()
                AnimationQualityButton(fontSize: fontSize)
                Spacer()
                GameBackgroundButton(fontSize: fontSize)
            }
            .frame(height: height)
            .position(x: width * 0.9, y: height * 0.5)
            
        }
        .frame(width: width, height: height)
    }
}

struct YTSettingsElement_Previews: PreviewProvider {
    static var previews: some View {
        YTSettingsElement(fontSize: 15, stepperWidth: 60, stepperHeight: 20, spacing: 6, width: Constants.screenWidth * 0.33, height: Constants.screenHeight * 0.25)
    }
}

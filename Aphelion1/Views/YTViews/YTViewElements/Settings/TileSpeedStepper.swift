//
//  SpeedStepper.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/2.
//

import SwiftUI

struct TileSpeedStepper: View {
    
    @State var tileSpeed10 = 5 - Int((tileSpeed - tileSpeedOriginal) / 0.1)
    var width: CGFloat
    var height: CGFloat
    var spacing: CGFloat
    
    var body: some View {
        ZStack {
            Image("PauseStepper")
                .resizable()
                .frame(width: width, height: height)
            
            HStack(spacing: spacing) {
                //minus
                Button(action: {
                    if tileSpeed10 > 1 {
                        tileSpeed += 0.1
                        tileSpeed10 -= 1
                    }
                }, label: {
                    Image(systemName: "minus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: height - 11)
                        .foregroundColor(.white)
                        .frame(width: height, height: height)
                        .contentShape(Rectangle())
                })
                //number
                Text(String(tileSpeed10))
                    .font(.custom("Avenir Next Regular", size: height - 5))
                    .foregroundColor(.white)
                    .frame(width: height)
                //plus
                Button(action: {
                    if tileSpeed10 < 10 {
                        tileSpeed -= 0.1
                        tileSpeed10 += 1
                    }
                }, label: {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(height: height - 11)
                        .foregroundColor(.white)
                        .frame(width: height, height: height)
                        .contentShape(Rectangle())
                })
            }
        }
    }
}

struct TileSpeedStepper_Previews: PreviewProvider {
    static var previews: some View {
        TileSpeedStepper(width: 94, height: 20, spacing: 12)
    }
}

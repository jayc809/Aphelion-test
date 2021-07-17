//
//  GameplaySettings.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/18.
//

import SwiftUI

struct DifficultyButton: View {
    
    @State var _difficulty = difficulty
    var fontSize: CGFloat
    
    var body: some View {
        Button(action: {
            if difficulty < 4 {
                difficulty += 1
                _difficulty += 1
            }
            else {
                difficulty = 1
                _difficulty = 1
            }
        }, label: {
            Text(_difficulty == 1 ? "Easy" : _difficulty == 2 ? "Medium" : _difficulty == 3 ? "Hard" : "Specialist")
                .font(Font.system(size: fontSize))
                .foregroundColor(.white)
                .bold()
        })
    }
}

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

struct SlideNoteButton: View {
    @State var _slideNoteOff = slideNoteOff
    var fontSize: CGFloat
    
    var body: some View {
        Button(action: {
            if _slideNoteOff == false {
                slideNoteOff = true
                _slideNoteOff = true
            }
            else {
                slideNoteOff = false
                _slideNoteOff = false
            }
        }, label: {
            Text(_slideNoteOff == false ? "On" :"Off")
                .font(Font.system(size: fontSize))
                .foregroundColor(.white)
                .bold()
        })
    }
}

struct DivineBoostButton: View {
    @State var _divineBoostOff = divineBoostOff
    var fontSize: CGFloat
    
    var body: some View {
        Button(action: {
            if _divineBoostOff == false {
                divineBoostOff = true
                _divineBoostOff = true
            }
            else {
                divineBoostOff = false
                _divineBoostOff = false
            }
        }, label: {
            Text(_divineBoostOff == false ? "On" :"Off")
                .font(Font.system(size: fontSize))
                .foregroundColor(.white)
                .bold()
        })
    }
}

struct DifficultyButton_Previews: PreviewProvider {
    static var previews: some View {
        DifficultyButton(fontSize: 20)
    }
}

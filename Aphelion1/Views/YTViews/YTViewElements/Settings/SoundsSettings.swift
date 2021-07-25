//
//  SoundsSettings.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/18.
//

import SwiftUI

struct SoundEffectsButton: View {
    
    @State var _soundEffectsOff = soundEffectsOff
    var fontSize: CGFloat
    
    var body: some View {
        Button(action: {
            if _soundEffectsOff == false {
                soundEffectsOff = true
                _soundEffectsOff = true
            }
            else {
                soundEffectsOff = false
                _soundEffectsOff = false
            }
        }, label: {
            Text(_soundEffectsOff == false ? "Enabled" :"Disabled")
                .font(Font.system(size: fontSize))
                .foregroundColor(.white)
                .bold()
        })
    }
}

struct AudioOffsetStepper: View {
    
    @State var _audioOffset = audioOffset
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
                    if audioOffset > -20 {
                        audioOffset -= 1
                        _audioOffset -= 1
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
                Text(String(_audioOffset))
                    .font(.custom("Avenir Next Regular", size: height - 5))
                    .foregroundColor(.white)
                    .frame(width: width * 0.4)
                //plus
                Button(action: {
                    if audioOffset < 20 {
                        audioOffset += 1
                        _audioOffset += 1
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

struct SoundsSettings_Previews: PreviewProvider {
    static var previews: some View {
        AudioOffsetStepper(width: 80, height: 20, spacing: 2)
    }
}

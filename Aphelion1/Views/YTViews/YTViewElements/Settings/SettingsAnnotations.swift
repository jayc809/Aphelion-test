//
//  SettingsAnnotations.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/26.
//

import SwiftUI

struct SettingsAnnotations: View {
    
    @Binding var showAnnotations: Int
    var width: CGFloat
    var fontSize: CGFloat
    
    var body: some View {
        ZStack {
            if showAnnotations != 1 {
                
                Image("PauseMenu")
                    .resizable()
                
                ScrollView(showsIndicators: false) {
                    if showAnnotations == 2 {
                        //animation offset
                        Text("Animation Offset - Increase value if hit detection is late. Decrease value if hit detection is early. Measured in frames.")
                            .font(Font.system(size: fontSize))
                            .foregroundColor(.white)
                            .padding(fontSize * 0.5)
                    }
                    else if showAnnotations == 3 {
                        //background
                        Text("Background - Value sets the background element shown during gameplay.")
                            .font(Font.system(size: fontSize))
                            .foregroundColor(.white)
                            .padding(fontSize * 0.5)
                    }
                    else if showAnnotations == 4 {
                        //brightness saturation
                        Text("Brightness & Saturation - Value sets the brightness and saturation applied to the bakcground element selected.")
                            .font(Font.system(size: fontSize))
                            .foregroundColor(.white)
                            .padding(fontSize * 0.5)
                    }
                    else if showAnnotations == 5 {
                        //audio offset
                        Text("Audio Offset - Increase value if notes arrive early. Decrease value if notes arrive late. Measured in ms.")
                            .font(Font.system(size: fontSize))
                            .foregroundColor(.white)
                            .padding(fontSize * 0.5)
                    }
                }
                
                Button(action: {
                    showAnnotations = 1
                }, label: {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .frame(width: fontSize, height: fontSize)
                        .foregroundColor(.white)
                        .background(Color.black)
                })
                .position(x: width, y: 0)
            }
            
        }
        .frame(width: width, height: width * 0.4)
    }
}


struct SettingsAnnotationsPreview: View {
    @State var showAnnotations = 2
    var body: some View {
        SettingsAnnotations(showAnnotations: $showAnnotations, width: 300, fontSize: 20)
    }
}

struct SettingsAnnotations_Previews: PreviewProvider {
    static var previews: some View {
        SettingsAnnotationsPreview()
    }
}

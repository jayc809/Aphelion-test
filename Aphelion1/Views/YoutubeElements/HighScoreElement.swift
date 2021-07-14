//
//  HighScoreElement.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/14.
//

import SwiftUI

struct HighScoreElement: View {
    
    var highScore: Int
    var tier: String
    var fontSize: CGFloat
    var width: CGFloat
    var height: CGFloat {
        return width * 0.226
    }
    var fullCombo: String
    
    var body: some View {
        
        ZStack {
            
            VStack(spacing: 2) {
                
                ZStack {
                    
                    Image("HighScoreBackground")
                        .resizable()
                        .scaledToFit()
                    
                    VStack {
                        HStack {
                            Text("High Score")
                                .font(Font.system(size: fontSize * 0.8))
                                .italic()
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                            Text(String(format: "%010d", highScore))
                                .font(Font.custom("Gill Sans Light Italic", size: fontSize * 1.2))
                        }
                    }
                    .frame(width: width * 0.6)
                    .offset(x: width / 40)
                    
                }
                .frame(width: width, height: height)
                
                if fullCombo == "Divine" {
                    Text("- Full Divine -")
                        .font(Font.system(size: fontSize * 0.8))
                }
                else if fullCombo == "Combo" {
                    Text("- Full Combo -")
                        .font(Font.system(size: fontSize * 0.8))
                }
                else {
                    Text(" ")
                        .font(Font.system(size: fontSize * 0.8))
                }
            
            }
            
            Image("\(tier)Tier")
                .resizable()
                .scaledToFit()
                .frame(width: width * 0.4 , height: width * 0.4)
                .offset(x: width * 0.21, y: -width * 0.27)
            
        }
    }
}

struct HighScoreElement_Previews: PreviewProvider {
    static var previews: some View {
        HighScoreElement(highScore: 328984, tier: "S", fontSize: 30, width: 400, fullCombo: "")
            
    }
}

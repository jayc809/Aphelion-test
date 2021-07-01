//
//  ScoreElement.swift
//  Aphelion
//
//  Created by Jay on 2021/6/2.
//

import SwiftUI

struct ScoreElement: View {
    
    var score: Int
    @State var currScore = 0
    @State var prevScore = 0
    @State var timer = Timer.publish(every: 0.05, on: .current, in: .common).autoconnect()
    
    var body: some View {
        
        Text(String(format: "%08d", currScore))
            .font(.custom(Constants.fontLightItalic, size: 35))
            .foregroundColor(.white)
            .tracking(2)
            .glow(color: .white, radius: 0.2, scale: 0.5)
            .frame(width: 200, alignment: .trailing)
            .onReceive(timer) { _ in
                if currScore <= (score - 17) {
                    currScore += 17
                }
                else {
                    currScore = score
                }
            }
            .onChange(of: score) { score in
                currScore = prevScore
                prevScore = score
            }
        
    }
}

struct ScoreElement_Previews: PreviewProvider {
    static var previews: some View {
        ScoreElement(score: 69420)
    }
}

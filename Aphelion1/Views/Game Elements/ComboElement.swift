//
//  ComboElement.swift
//  Aphelion
//
//  Created by Jay on 2021/6/2.
//

import SwiftUI

struct ComboElement: View {
    
    var combo: Int
    var showDivine: Bool
    
    @State var show = 1 //slide in - 1, slide out - 2, fade out - 3
    @State var offset = true
    @State var playAnimation = true
    @State var timer = Timer.publish(every: 2.5, on: .current, in: .common).autoconnect()
    
    var body: some View {
        
        ZStack {
            
            VStack(spacing: 0) {
            
                Text(combo >= 200 ? "x\(String(combo))!" : "x\(combo)")
                    .font(Font.custom(Constants.fontLightItalic, size: 45))
                    .foregroundColor(.white)
                    .tracking(4)
                    .glow(color: .white, radius: 0.3, scale: 0)
                    .glow(color: Constants.purple, radius: 2, scale: 0.5)
                    .frame(width: 200, height: 45, alignment: .trailing)
                
                Text("divine")
                    .font(Font.custom(Constants.fontNormalItalic, size: 22))
                    .foregroundColor(.white)
                    .tracking(1.5)
                    .glow(color: Constants.purple, radius: 1.5, scale: 0.5)
                    .frame(width: 200, height: 22, alignment: .trailing)
                    .offset(combo < 10 ? CGSize(width: -2, height: 0) :
                            combo < 100 ? CGSize(width: -10, height: 0) :
                            combo < 200 ? CGSize(width: -14, height: 0) :
                            combo < 1000 ? CGSize(width: -24, height: 0) :
                            CGSize(width: -32, height: 0))
                    .opacity(showDivine ? 1 : 0)
            }
            
            if playAnimation {
                PlayGif(fileName: "ComboAnimation", maxNum: 15, frameY: 300)
                    .offset(combo < 10 ? CGSize(width: 70, height: -10) :
                            combo < 100 ? CGSize(width: 60, height: -10) :
                            combo < 200 ? CGSize(width: 50, height: -10) :
                            combo < 1000 ? CGSize(width: 42, height: -10) :
                            CGSize(width: 32, height: 0))
            }
            else {
                PlayGif(fileName: "ComboAnimation", maxNum: 15, frameY: 300)
                    .offset(combo < 10 ? CGSize(width: 70, height: -10) :
                            combo < 100 ? CGSize(width: 60, height: -10) :
                            combo < 200 ? CGSize(width: 50, height: -10) :
                            combo < 1000 ? CGSize(width: 42, height: -10) :
                            CGSize(width: 32, height: 0))
            }
            
            
        }
        .hueRotation(determineHue(combo: combo))
        .opacity(show == 1 ? 0 : show == 2 ? 1 : show == 3 ? 0 : 0)
        .offset(offset ? CGSize(width: 60, height: 0) : CGSize(width: 0, height: 0))
        .onAppear{ slide() }
        .onChange(of: combo) { _ in
            
            //reset properties
            offset = true
            show = 1
            //action
            playAnimation.toggle()
            slide()
            //reset timer
            timer = Timer.publish(every: 2.5, on: .current, in: .common).autoconnect()
            
        }
        .onReceive(timer) { _ in fadeOut() }
        
    }
    
    func slide() {
        withAnimation(Animation.timingCurve(0.5, 0, 0.5, 0.8, duration: 0.15)) {
            offset = false
            show = 2
        }
    }
    
    func fadeOut() {
        withAnimation(Animation.easeIn(duration: 0.2)) {
            show = 3
        }
    }
}

struct ComboElement_Previews: PreviewProvider {
    static var previews: some View {
        ComboElement(combo: 27, showDivine: true)
    }
}

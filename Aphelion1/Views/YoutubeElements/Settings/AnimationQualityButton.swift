//
//  AnimationQualityButton.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/14.
//

import SwiftUI

struct AnimationQualityButton: View {
    
    @State var _animationQuality = animationQuality
    var fontSize: CGFloat
    
    var body: some View {
        Button(action: {
            if animationQuality < 3 {
                animationQuality += 1
                _animationQuality += 1
            }
            else {
                animationQuality = 1
                _animationQuality = 1
            }
        }, label: {
            Text(_animationQuality == 1 ? "Stable" : _animationQuality == 2 ?  "Smooth" : "Best")
                .font(Font.system(size: fontSize))
                .foregroundColor(.white)
                .bold()
        })
    }
}

struct AnimationQualityButton_Previews: PreviewProvider {
    static var previews: some View {
        AnimationQualityButton(fontSize: 20)
    }
}

//
//  GameBackgroundButton.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/15.
//

import SwiftUI

struct GameBackgroundButton: View {
    
    @State var _useBackground = useBackground
    var fontSize: CGFloat
    
    var body: some View {
        Button(action: {
            if useBackground < 3 {
                useBackground += 1
                _useBackground += 1
            }
            else {
                useBackground = 1
                _useBackground = 1
            }
        }, label: {
            Text(_useBackground == 1 ? "Video" : _useBackground == 2 ?  "Custom Image" : "Video Thumbnail")
                .font(Font.system(size: fontSize))
                .foregroundColor(.white)
                .bold()
        })
    }
    
}

struct GameBackgroundButton_Previews: PreviewProvider {
    static var previews: some View {
        GameBackgroundButton(fontSize: 20)
    }
}

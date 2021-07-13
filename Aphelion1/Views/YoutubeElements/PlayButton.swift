//
//  PlayButton.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/11.
//

import SwiftUI

struct PlayButton: View {
    
    var width: CGFloat
    
    var body: some View {
        
        Button {
            
        } label: {
            ZStack {
                Rectangle()
                    .frame(width: width, height: width * 0.15)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                
                Text("Start Game")
                    .bold()
                    .foregroundColor(.black)
            }
        }
    }
}

struct PlayButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayButton(width: 150)
    }
}

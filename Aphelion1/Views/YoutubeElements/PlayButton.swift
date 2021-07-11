//
//  PlayButton.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/11.
//

import SwiftUI

struct PlayButton: View {
    var body: some View {
        Button {
            
        } label: {
            ZStack {
                Rectangle()
                    .frame(width: 180, height: 30)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                
                Text("Play")
                    .foregroundColor(.black)
            }
        }
        
        Spacer()
    }
}

struct PlayButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayButton()
    }
}

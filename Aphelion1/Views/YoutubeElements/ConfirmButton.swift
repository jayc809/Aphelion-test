//
//  ConfirmButton.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/15.
//

import SwiftUI

struct ConfirmButton: View {
    
    var fontSize: CGFloat
    var width: CGFloat
    
    var body: some View {
        Button(action: {
            
        }, label: {
            ZStack {
                
                Image("PauseMenu")
                    .resizable()
                    .colorInvert()
                
                Text("Confirm Selection")
                    .font(Font.system(size: fontSize))
                    .foregroundColor(.black)
                    .bold()
                
            }
        })
        .frame(width: width, height: width * 0.15)
    }
}

struct ConfirmButton_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmButton(fontSize: 20, width: 200)
    }
}

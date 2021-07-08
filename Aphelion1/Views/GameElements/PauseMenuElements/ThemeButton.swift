//
//  ThemeButton.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/2.
//

import SwiftUI

struct ThemeButton: View {
    
    @State var tileTypeShow = tileType
    var height: CGFloat
    
    var body: some View {
        Button(action: {
            if tileType == "Regular" {
                tileType = "Beat"
                tileTypeShow = "Beat"
            }
            else {
                tileType = "Regular"
                tileTypeShow = "Regular"
            }
        }, label: {
            Image("Tap\(tileTypeShow)Pause")
                .resizable()
                .scaledToFit()
                .frame(height: height)
        })
    }
}

struct ThemeButton_Previews: PreviewProvider {
    static var previews: some View {
        ThemeButton(height: 25)
    }
}

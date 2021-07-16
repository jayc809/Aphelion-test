//
//  DifficultyButton.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/14.
//

import SwiftUI

struct DifficultyButton: View {
    
    @State var _difficulty = difficulty
    var fontSize: CGFloat
    
    var body: some View {
        Button(action: {
            if difficulty < 4 {
                difficulty += 1
                _difficulty += 1
            }
            else {
                difficulty = 1
                _difficulty = 1
            }
        }, label: {
            Text(_difficulty == 1 ? "Easy" : _difficulty == 2 ? "Medium" : _difficulty == 3 ? "Hard" : "Specialist")
                .font(Font.system(size: fontSize))
                .foregroundColor(.white)
                .bold()
        })
    }
}

struct DifficultyButton_Previews: PreviewProvider {
    static var previews: some View {
        DifficultyButton(fontSize: 20)
    }
}

//
//  TestTile.swift
//  Aphelion
//
//  Created by Jay on 2021/6/29.
//

import SwiftUI

struct TestTile: View {
    
    @State var position = CGPoint(x: Constants.halfScreenWidth, y: Constants.tileYMin)
    @State var frames = 0
    var gameModel: GameModel
    
    var body: some View {
        Image("TapBeat")
            .resizable()
            .scaledToFit()
            .frame(width: Constants.tileSize)
            .position(position)
            .onReceive(timerTile) { _ in
                withAnimation {
                    position.y += 40
                }
            }
    }
}


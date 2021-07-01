//
//  TestViewSimple.swift
//  Aphelion
//
//  Created by Jay on 2021/6/19.
//

import SwiftUI

struct ContentView: View {
    @State var offset = CGFloat(0)
    @State var offset2 = CGFloat(0)
    @ObservedObject var gameModel = GameModel()
    
    var body: some View {
        VStack {
           TestTile(gameModel: gameModel)
        }
        .ignoresSafeArea()
        .frame(width: Constants.screenWidth, height: Constants.screenHeight * 10)
        .position(x: Constants.halfScreenWidth, y: Constants.halfScreenHeight - Constants.halfScreenHeight * 9)
        .rotation3DEffect(.degrees(56), axis: (x: 1, y: 0, z: 0), anchor: .bottom, anchorZ: 0, perspective: 1)
    }
}

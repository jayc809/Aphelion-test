//
//  TestView.swift
//  Aphelion
//
//  Created by Jay on 2021/6/15.
//

import SwiftUI

struct TestView: View {
    
    @ObservedObject var gameModel = GameModel()
    @StateObject var playerManager = PlayerManager()
    
    @State var combo = 0
    @State var score = 0
    @State var showDivine = false
    @State var deploy = false
    @State var timer = Timer.publish(every: 2, on: .current, in: .common).autoconnect()
    @State var x1 = CGFloat.random(in: Constants.tileXMin...Constants.tileXMax)
    @State var x2 = CGFloat.random(in: Constants.tileXMin...Constants.tileXMax)
    
    
    var body: some View {
        
        ZStack {
            
            AVPlayerControllerRepresented(player: playerManager.player)
                .onAppear {
                    playerManager.play()
                }
                .scaledToFill()
                .frame(width: Constants.screenWidth, height: Constants.screenHeight)
                .ignoresSafeArea()
                .saturation(videoSaturation)
                .brightness(videoBrightness)
            
            Image("GameView")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            Image("TapLine")
                .resizable()
                .scaledToFit()
                .position(x: Constants.screenWidth / 2, y: Constants.tapLinePosition)
                .ignoresSafeArea()
            
            //score element
            ScoreElement(score: score)
                .position(x: Constants.screenWidth - 110, y: 25)
            
            //combo element
            if combo > 0 {
                ComboElement(combo: combo, showDivine: showDivine)
                    .position(x: Constants.screenWidth - 130, y: Constants.screenHeight * 0.85 / 2)
            }
            
            if deploy {
                SlideTile(endX: 100, gameModel: gameModel, side: "right", combo: $combo, score: $score, showDivine: $showDivine)
                TapTile(endX: -100, gameModel: gameModel, combo: $combo, score: $score, showDivine: $showDivine)
            }
            else {
                SlideTile(endX: 100, gameModel: gameModel, side: "right", combo: $combo, score: $score, showDivine: $showDivine)
                TapTile(endX: -100, gameModel: gameModel, combo: $combo, score: $score, showDivine: $showDivine)
            }
        }
        .onReceive(timer, perform: { _ in
            x1 = CGFloat.random(in: Constants.tileXMin...Constants.tileXMax)
            x2 = CGFloat.random(in: Constants.tileXMin...Constants.tileXMax)
            deploy.toggle()
        })
        .background(Color.black)
    }
}

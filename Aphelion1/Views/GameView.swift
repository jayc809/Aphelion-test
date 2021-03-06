//
//  GameView.swift
//  Aphelion
//
//  Created by Jay on 2021/6/1.
//

import SwiftUI

var timerTile = Timer.publish(every: tileSpeed / 100, on: .main, in: .common).autoconnect()
var timerTest = Timer.publish(every: 1.2, on: .current, in: .common).autoconnect()
var timerHold = Timer.publish(every: 0.15, on: .current, in: .common).autoconnect()

struct GameView: View {
    
    @ObservedObject var gameModel = GameModel()
    @StateObject var playerManager = PlayerManager(file: "GHOST.mp4")
    
    @State var combo = 0
    @State var score = 0
    @State var showDivine = false
    @State var isPaused = false
    
    //for testing
    @State var deploy1 = false
    @State var x1 = CGFloat.random(in: Constants.tileXMin...Constants.tileXMax)
    @State var deploy2 = false
    @State var x2 = CGFloat.random(in: Constants.tileXMin...Constants.tileXMax)
    @State var deploy3 = false
    @State var x3 = CGFloat.random(in: Constants.tileXMin...Constants.tileXMax)
    @State var deploy4 = false
    @State var x4 = CGFloat.random(in: Constants.tileXMin...Constants.tileXMax)
    @State var ii = 1
    
    var body: some View {
        
        ZStack {
            
            //video
            AVPlayerControllerRepresented(player: playerManager.player)
                .onAppear {
                    playerManager.play()
                }
                .scaledToFill()
                .frame(width: Constants.screenWidth, height: Constants.screenHeight)
                .ignoresSafeArea()
                .saturation(videoSaturation)
                .brightness(videoBrightness)
                
            
            //background elements
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
            
            //tiles
            LazyVStack {
                
                ZStack {
                    
                    if deploy1 {
                        //Tile(type: "Beat", endX: x1, combo: $combo, score: $score)
                        //TapTile(endX: x1, gameModel: gameModel, combo: $combo, score: $score, showDivine: $showDivine)
                        HoldTile(location: "Right", lineHeight: 2000, gameModel: gameModel, combo: $combo, score: $score, showDivine: $showDivine)
                        HoldTile(location: "Left", lineHeight: 2000, gameModel: gameModel, combo: $combo, score: $score, showDivine: $showDivine)
                    }
                    if deploy2 {
                        //Tile(type: "Beat", endX: x2, combo: $combo, score: $score)
                        TapTile(endX: x2, gameModel: gameModel, combo: $combo, score: $score, showDivine: $showDivine)
                    }
                    if deploy3 {
                        //Tile(type: "Regular", endX: x3, combo: $combo, score: $score)
                        SlideTile(endX: x3, gameModel: gameModel, side: "Left", combo: $combo, score: $score, showDivine: $showDivine)
                    }
                    if deploy4 {
                        //Tile(type: "Regular", endX: x4, combo: $combo, score: $score)
                        TapTile(endX: x4, gameModel: gameModel, combo: $combo, score: $score, showDivine: $showDivine)
                    }
                    
                }
                .frame(width: Constants.screenWidth, height: Constants.screenHeight)
            }
            .onReceive(timerTest) { _ in
                
                if ii == 1 {
                    deploy1 = true
                    x1 = CGFloat.random(in: Constants.tileXMin...Constants.tileXMax)
                    deploy2 = false
                    ii = 2
                }
                else if ii == 2 {
                    deploy2 = true
                    x2 = CGFloat.random(in: Constants.tileXMin...Constants.tileXMax)
                    deploy3 = false
                    ii = 3
                }
                else if ii == 3 {
                    deploy3 = true
                    x3 = CGFloat.random(in: Constants.tileXMin...Constants.tileXMax)
                    deploy4 = false
                    ii = 4
                }
                else if ii == 4 {
                    deploy4 = true
                    x4 = CGFloat.random(in: Constants.tileXMin...Constants.tileXMax)
                    deploy1 = false
                    ii = 1
                }
            }
        
            //pause button
            if isPaused == false {
                Button(action: {
                    
                    timerTile.upstream.connect().cancel()
                    timerTest.upstream.connect().cancel()
                    playerManager.playPause()
                    isPaused = true
                    
                }, label: {
                    Image(systemName: "pause")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 22)
                        .foregroundColor(.white)
                })
                .frame(width: 500, height: 500)
                .contentShape(Rectangle())
                .position(x: 25, y: 20)
            }
            
            //pause menu
            if isPaused {
                PauseMenu(isPaused: $isPaused, playerManager: playerManager)
            }
            
            //combo element
            if combo > 0 {
                ComboElement(combo: combo, showDivine: showDivine)
                    .position(x: Constants.screenWidth - 130, y: Constants.screenHeight * 0.85 / 2)
            }
            
        }
        .frame(width: Constants.screenWidth, height: Constants.screenHeight)
        .background(Color.black)
        .ignoresSafeArea()
    }
}


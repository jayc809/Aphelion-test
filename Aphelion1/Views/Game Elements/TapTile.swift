//
//  TapTile.swift
//  Aphelion
//
//  Created by Jay on 2021/6/15.
//

import SwiftUI

struct TapTile: View {
    
    //input
    var endX: CGFloat
    var gameModel: GameModel
    @Binding var combo: Int
    @Binding var score: Int
    @Binding var showDivine: Bool
    
    //frames
    @State var frames = 0
    
    //geometry
    @State var position = CGPoint(x: Constants.halfScreenWidth, y: Constants.tileYMin)
    @State var positionAdjusted = CGPoint(x: Constants.halfScreenWidth, y: Constants.tileYMin)
    @State var size = CGFloat(0.01)
    @State var sizeAdjusted = CGFloat(0.01)
    @State var opacity = CGFloat(0.7)
    
    //states
    @State var show = 1 //moving - 1, divine - 2, good - 3, miss - 4
    
    var body: some View {
        
        if show == 1 {
            Image("Tap\(tileType)")
                .resizable()
                .scaledToFit()
                .rotation3DEffect(.degrees(10), axis: (x: 1, y: 0, z: 0))
                .frame(width: Constants.tileSize)
                .scaleEffect(size)
                .opacity(Double(opacity))
                .hueRotation(determineHue(combo: combo))
                .position(position)
                .onReceive(timerTile) { _ in
                    //change location and size
                    moveTile()
                    //update frames and check for miss off gird
                    frames += 1
                    missTile()
                }
                .gesture(tap)
        }
        //divine
        else if show == 2 {
            PlayGif(fileName: "TapDiv", maxNum: 25, frameY: Constants.tileAnimationSize)
                .scaleEffect(sizeAdjusted)
                .hueRotation(determineHue(combo: combo))
                .position(x: positionAdjusted.x, y: Constants.tapLinePosition)
            
        }
        //good
        else if show == 3 {
            PlayGif(fileName: "TapGood", maxNum: 30, frameY: Constants.tileAnimationSize)
                .scaleEffect(sizeAdjusted)
                .hueRotation(determineHue(combo: combo))
                .position(x: positionAdjusted.x, y: positionAdjusted.y)
        }
        //miss
        else if show == 4 {
            PlayGif(fileName: "TapMiss", maxNum: 30, frameY: Constants.tileAnimationSize)
                .scaleEffect(sizeAdjusted)
                .hueRotation(determineHue(combo: combo))
                .position(x: positionAdjusted.x, y: positionAdjusted.y)
        }
        
    }
    
    func moveTile() {
        if frames < (gameModel.tilePositionArray.count - 1) {
            //before tapline, lags
            withAnimation {
                position.x = (endX * gameModel.tileScaleArray[frames]) + Constants.halfScreenWidth
                position.y = gameModel.tilePositionArray[frames]
                size = gameModel.tileScaleArray[frames]
                opacity = gameModel.tileScaleArray[frames] + 0.6
            }
        }
    }
    
    func missTile() {
        if frames == (gameModel.tilePositionArray.count - 1) {
            combo = 0
            showDivine = false
        }
    }
    
    var tap: some Gesture {
        
        DragGesture(minimumDistance: 0)
            .onChanged { _ in
        
                positionAdjusted.x = (endX * gameModel.tileScaleArray[frames - framesAdjusted]) + Constants.halfScreenWidth
                positionAdjusted.y = gameModel.tilePositionArray[frames - framesAdjusted]
                sizeAdjusted = gameModel.tileScaleArray[frames - framesAdjusted]
                
                //divine
                if abs(Constants.tapLinePosition - positionAdjusted.y) <= toleranceDiv {
                    show = 2
                    combo += 1
                    showDivine = true
                    score += Int(150 * (100 + combo) / 100)
                }
                //good
                else if abs(Constants.tapLinePosition - positionAdjusted.y) <= toleranceGood {
                    show = 3
                    combo += 1
                    showDivine = false
                    score += Int(100 * (100 + combo) / 100)
                }
                //miss
                else if abs(Constants.tapLinePosition - positionAdjusted.y) > toleranceGood {
                    show = 4
                    showDivine = false
                    combo = 0
                }
            }
        
    }
}


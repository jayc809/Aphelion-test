//
//  HoldTile.swift
//  Aphelion
//
//  Created by Jay on 2021/6/18.
//

import SwiftUI
import Foundation

struct HoldTile: View {

    //input
    var location: String
    //
    //add length control here
    var lineHeight: CGFloat
    var lineWidth = Constants.tileSize / 4
    //
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
    @State var opacityTile = CGFloat(0.7)
    @State var opacityLine = CGFloat(0.6)
    @State var clipOffset = CGFloat(0)
    var endX: CGFloat {
        if location == "right" {
            return Constants.tileXMax
        }
        else {
            return Constants.tileXMin
        }
    }
    var angle: Angle {
        let ratio = Double(endX / (Constants.tapLinePosition + abs(Constants.tileYMin)))
        return Angle.radians(-atan(ratio))
    }

    @State var show = 1 // moving - 1, divine - 2, good - 3, miss - 4, end - 5
    
    var body: some View {
        ZStack {
            //line
            Group {
                VStack {
                    Image("Line\(tileType)")
                        .resizable()
                        .frame(width: lineWidth, height: lineHeight)
                    Spacer()
                }
                .frame(height: lineHeight * 2)
                .rotationEffect(angle)
                .scaleEffect(size)
                .opacity(Double(opacityLine))
                .position(x: position.x, y: position.y - clipOffset)
            }
            .frame(width: Constants.screenWidth, height: Constants.screenHeight)
            .clipped()
            .position(x: Constants.halfScreenWidth, y: Constants.halfScreenHeight + clipOffset)
            //tile
            Group {
                ZStack {
                    //moving tile
                    if show == 1 {
                        Image("Hold\(tileType)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: Constants.tileSize)
                            .rotation3DEffect(.degrees(10), axis: (x: 1, y: 0, z: 0))
                            .scaleEffect(size)
                            .position(position)
                    }
                    //divine
                    else if show == 2 {
                        PlayGifLoop(fileName: "HoldDiv", loopStart: 26, loopEnd: 52, frameY: Constants.tileAnimationSize)
                            .scaleEffect(sizeAdjusted)
                            .position(positionAdjusted)
                            .onAppear {
                                whenHeld(accuracy: "divine")
                                opacityLine = 0.9
                            }
                            .onReceive(timerHold) { _ in
                                whenHeld(accuracy: "divine")
                            }
                    }
                    //good
                    else if show == 3 {
                        PlayGifLoop(fileName: "HoldGood", loopStart: 26, loopEnd: 52, frameY: Constants.tileAnimationSize)
                            .scaleEffect(sizeAdjusted)
                            .position(positionAdjusted)
                            .onAppear {
                                whenHeld(accuracy: "good")
                                opacityLine = 0.9
                            }
                            .onReceive(timerHold) { _ in
                                whenHeld(accuracy: "good")
                            }
                    }
                    //miss
                    else if show == 4 {
                        PlayGif(fileName: "TapMiss", maxNum: 30, frameY: Constants.tileAnimationSize)
                            .scaleEffect(sizeAdjusted)
                            .position(positionAdjusted)
                            .opacity(0.7)
                            .onAppear {
                                combo = 0
                                showDivine = false
                                withAnimation(.linear(duration: 0.3)) {
                                    opacityLine = 0
                                }
                            }
                    }
                    //end
                    else if show == 5 {
                        PlayGif(fileName: "HoldEnd", maxNum: 30, frameY: Constants.tileAnimationSize)
                            .scaleEffect(sizeAdjusted)
                            .position(positionAdjusted)
                            .onAppear {
                                withAnimation(.linear(duration: 0.3)) {
                                    opacityLine = 0
                                }
                            }
                    }
                }
                .opacity(Double(opacityTile))
                .gesture(hold)
                .onReceive(timerTile) { _ in
                    moveTile()
                    frames += 1
                }
            }
        }
        .hueRotation(determineHue(combo: combo))
    }

    var hold: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { _ in
                if show == 1 {
                    //adjust geometry
                    positionAdjusted.x = (endX * gameModel.tileScaleArray[frames - framesAdjusted]) + Constants.halfScreenWidth
                    positionAdjusted.y = gameModel.tilePositionArray[frames - framesAdjusted]
                    sizeAdjusted = gameModel.tileScaleArray[frames - framesAdjusted]
                    
                    //detect divine
                    if abs(Constants.tapLinePosition - positionAdjusted.y) <= toleranceDiv {
                        positionAdjusted.y = Constants.tapLinePosition
                        positionAdjusted.x = endX + Constants.halfScreenWidth
                    }
                    
                    if positionAdjusted.y > Constants.screenHeight {
                        show = 4
                    }
                    else if positionAdjusted.y == Constants.tapLinePosition {
                        clipOffset = -(Constants.screenHeight - Constants.tapLinePosition)
                        show = 2
                    }
                    else if abs(Constants.tapLinePosition - positionAdjusted.y) <= toleranceGood {
                        clipOffset = -(Constants.screenHeight - positionAdjusted.y)
                        show = 3
                    }
                    else if abs(Constants.tapLinePosition - positionAdjusted.y) > toleranceGood {
                        clipOffset = -(Constants.screenHeight - positionAdjusted.y)
                        show = 4
                    }
                }
            }
            .onEnded { _ in
                if show != 4 {
                    show = 5
                }
            }
    }

    func moveTile() {
        let endXSpeed = endX * (gameModel.tileScaleArray[(gameModel.tileScaleArray.count - 1)] - gameModel.tileScaleArray[(gameModel.tileScaleArray.count - 2)])
        let endYSpeed = gameModel.tilePositionArray[(gameModel.tilePositionArray.count - 1)] - gameModel.tilePositionArray[(gameModel.tilePositionArray.count - 2)]
        
        if show == 1 {
            if frames < (gameModel.tilePositionArray.count - 1) {
                withAnimation {
                    position.x = (endX * gameModel.tileScaleArray[frames]) + Constants.halfScreenWidth
                    position.y = gameModel.tilePositionArray[frames]
                    size = gameModel.tileScaleArray[frames]
                    opacityTile = gameModel.tileScaleArray[frames] + 0.6
                }
            }
            else {
                combo = 0
                showDivine = false
                withAnimation(.linear(duration: 0.3)) {
                    opacityLine = 0
                }
            }
        }
        else {
            withAnimation {
                position.x += endXSpeed
                position.y += endYSpeed
            }
        }
    }

    func whenHeld(accuracy: String) {
        combo += 1
        if accuracy == "divine" {
            showDivine = true
            score += Int(150 * (100 + combo) / 100)
        }
        else {
            showDivine = false
            score += Int(100 * (100 + combo) / 100)
        }
    }
}

//
//  TestView.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/4.
//

import SwiftUI

struct TestView: View {
    
    @ObservedObject var gameModel = GameModel()
    @State var combo = 0
    @State var score = 0
    @State var showDivine = false
    @State var type = "tap"
    var timer1 = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    
    var body: some View {
        
        ZStack {
            
            callTile(type: type)
            
        }
        .onReceive(timer1, perform: { _ in
            
            if type == "tap" {
                type = "slide"
            }
            else if type == "slide" {
                type = "hold"
            }
            else {
                type = "tap"
            }
        })
        
    }
    
    func callTile(type: String) -> some View {
        
        switch type {
        
        case "tap":
            return AnyView(TapTile(endX: 0, gameModel: gameModel, combo: $combo, score: $score, showDivine: $showDivine))
            
        case "slide":
            return AnyView(SlideTile(endX: 0, gameModel: gameModel, side: "left", combo: $combo, score: $score, showDivine: $showDivine))
            
        case "hold":
            return AnyView(HoldTile(location: "right", lineHeight: 2000, gameModel: gameModel, combo: $combo, score: $score, showDivine: $showDivine))
        
        default:
            return AnyView(EmptyTile())
            
        }
        
    }
    
    
}

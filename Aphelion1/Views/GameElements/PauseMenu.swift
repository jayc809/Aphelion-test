//
//  PauseMenu.swift
//  Aphelion
//
//  Created by Jay on 2021/6/30.
//

import SwiftUI

struct PauseMenu: View {
    
    @Binding var isPaused: Bool
    var playerManager: PlayerManager
    
    var body: some View {
        ZStack {
            
            Image("PauseMenu")
                .resizable()
            
            VStack {
                //frame
                HStack {
                    //tile theme button
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Tile Theme")
                            .font(.custom("Avenir Next Regular", size: 20))
                        Text("Tile Speed")
                            .font(.custom("Avenir Next Regular", size: 20))
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 15) {
                        //tile theme button
                        TileThemeButton(height: 25)
                        //tile speed stepper
                        TileSpeedStepper(width: 94, height: 20, spacing: 12)
                        
                    }
                }
                .frame(width: Constants.screenWidth * 0.4)
                .padding(30)
                
                
                HStack {
                    //resume button
                    Button(action: {
                        timerTile = Timer.publish(every: tileSpeed / 100, on: .main, in: .common).autoconnect()
                        timerTest = Timer.publish(every: 0.7, on: .current, in: .common).autoconnect()
                        playerManager.playPause()
                        isPaused = false
                    }, label: {
                        Text("Resume")
                            .font(.custom("Avenir Next Medium", size: 25))
                    })
                    Spacer()
                    //resume button
                    Button(action: {
                        
                    }, label: {
                        Text("Restart")
                            .font(.custom("Avenir Next Medium", size: 25))
                    })
                    Spacer()
                    //leave game button
                    Button(action: {
                        
                    }, label: {
                        Text("Return")
                            .font(.custom("Avenir Next Medium", size: 25))
                            //.padding()
                            //.border(Color.white)
                    })
                }
                .frame(width: Constants.screenWidth * 0.4)
                .padding(10)
            }
        }
        .frame(width: Constants.screenWidth * 0.6, height: Constants.screenHeight * 0.4)
        .foregroundColor(.white)
    }
}
//for preview
struct PauseMenu2: View {
    
    var player = PlayerManager(file: "GHOST.mp4")
    @State var pause = true
    
    var body: some View {
        
        PauseMenu(isPaused: $pause, playerManager: player)
        
    }
    
}

struct PauseMenu_Previews: PreviewProvider {
    static var previews: some View {
        return PauseMenu2().previewLayout(.fixed(width: Constants.screenWidth, height: Constants.screenHeight))
    }
}

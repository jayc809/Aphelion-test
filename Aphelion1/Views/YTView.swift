//
//  YTView.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/15.
//

import SwiftUI

var searchWord = "suisei song"

struct YTView: View {
    
    @StateObject var videoContent = YTContentModel()
    @State var imageData = Data()
    @State var selectedVideoInfo = YTVideoInfo()
    @State var searchedCount = 0
    
    let thumbnailWidth = Constants.screenWidth * 0.47
    let gradientLineHeight: CGFloat = 10
    
    var body: some View {
        ZStack {
            
            Image("test_star_background")
                .resizable()
            
            VStack {
                
                //search bar
                VStack {
                    SearchBarElement(searchedCount: $searchedCount, width: thumbnailWidth, fontSize: 18, offset: 0)
                    Image("GradientLine")
                        .resizable()
                        .frame(width: thumbnailWidth, height: gradientLineHeight)
                        .offset(y: -6)
                }
                
                //thumbnail and high score
                ZStack {
                    //thumbnail
                    ZStack {
                        VStack(spacing: 0) {
                            ThumbnailElement(imageData: imageData, imageWidth: thumbnailWidth)
                            Image("GradientLine")
                                .resizable()
                                .frame(width: thumbnailWidth, height: gradientLineHeight)
                        }
                    }
                    
                    //high score
                    HighScoreElement(highScore: 89320, tier: "A", fontSize: 15, width: Constants.screenWidth * 0.25, fullCombo: "")
                        .position(x: thumbnailWidth * 0.17, y: thumbnailWidth * 9 / 16 + gradientLineHeight * 1.5)
                        
                }
                .frame(width: thumbnailWidth, height: thumbnailWidth * 9 / 16 + gradientLineHeight)
                .padding(.bottom, gradientLineHeight * 3)
                .padding(.vertical,gradientLineHeight)
                
                //confirm button
                Button(action: {
                    
                    
                    
                }, label: {
                    ZStack {
                        Image("PauseMenu")
                            .resizable()
                            .colorInvert()
                        Text("Confirm Selection")
                            .font(Font.system(size: 18))
                            .foregroundColor(.black)
                            .bold()
                    }
                })
                .frame(width: Constants.screenWidth * 0.24, height: Constants.screenWidth * 0.24 * 0.15)
                
            }
            .frame(width: Constants.screenWidth * 0.5, height: Constants.screenHeight)
            .position(x: Constants.screenWidth * 0.29, y: Constants.screenHeight * 0.5)
            
            //gradient line
            Image("GradientLine")
                .resizable()
                .frame(width: Constants.screenHeight * 1.2, height: 10)
                .rotationEffect(Angle(degrees: 285))
                .position(x: Constants.screenWidth * 0.963, y: Constants.halfScreenHeight)
            
            //videos
            if searchedCount % 2 == 0 {
                ScrollListElement(imageData: $imageData, selectedVideoInfo: $selectedVideoInfo)
                    .position(x: Constants.screenWidth * 0.74, y: detectPosition)
                    .onAppear{
                        imageData = Data()
                    }
            }
            else {
                ScrollListElement(imageData: $imageData, selectedVideoInfo: $selectedVideoInfo)
                    .position(x: Constants.screenWidth * 0.74, y: detectPosition)
                    .onAppear{
                        imageData = Data()
                    }
            }
    
        }
    }
}

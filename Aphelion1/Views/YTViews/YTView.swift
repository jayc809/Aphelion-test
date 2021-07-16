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
    @State var showScrollList = 0
    @State var scrollListX = Constants.screenWidth * 0.73
    @State var videoDetailsX = Constants.screenWidth * 1.41
    @State var scrollListGradientLineX = Constants.screenWidth * 0.96
    
    let infoVStackX = Constants.screenWidth * 0.29
    let infoWidth = Constants.screenWidth * 0.47
    let thumbnailWidth = Constants.screenWidth * 0.42
    let gradientLineHeight: CGFloat = 20
    
    var body: some View {
        ZStack {
            
            Image("test_star_background")
                .resizable()
            
            Image("WhiteLine")
                .resizable()
                .frame(width: Constants.screenHeight * 1.2, height: 2)
                .rotationEffect(Angle(degrees: 105))
                .position(x: Constants.screenWidth - 15, y: Constants.screenHeight)
            
            Image("WhiteLine")
                .resizable()
                .frame(width: Constants.screenHeight * 1.2, height: 2)
                .rotationEffect(Angle(degrees: 105))
                .position(x: Constants.screenWidth - 30, y: Constants.screenHeight)
            
            Image("WhiteLine")
                .resizable()
                .frame(width: Constants.screenHeight * 1.2, height: 2)
                .rotationEffect(Angle(degrees: 105))
                .position(x: 15, y: 0)
            
            Image("WhiteLine")
                .resizable()
                .frame(width: Constants.screenHeight * 1.2, height: 2)
                .rotationEffect(Angle(degrees: 105))
                .position(x: 30, y: 0)
            
            VStack {
                
                //search bar
                VStack {
                    SearchBarElement(searchedCount: $searchedCount, width: infoWidth, fontSize: 18, offset: 0)
                    Image("GradientLine")
                        .resizable()
                        .frame(width: infoWidth, height: gradientLineHeight)
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
                    .offset(x: (infoWidth - thumbnailWidth) / 2 - 2)
                    
                    //high score
                    HighScoreElement(highScore: 89320, tier: "A", fontSize: 18, width: Constants.screenWidth * 0.3, fullCombo: "")
                        .position(x: infoWidth * 0.22, y: infoWidth * 9 / 16 + gradientLineHeight)
                        
                }
                .frame(width: infoWidth, height: infoWidth * 9 / 16 + gradientLineHeight)
                .padding(.bottom, gradientLineHeight * 1.5)
                
                //back next buttons
                HStack(spacing: 2) {
                    Button(action: {
                        
                    }, label: {
                        ZStack{
                            Image("BackButtonBackground")
                                .resizable()
                                .scaledToFit()
                            Text("Back")
                                .font(Font.system(size: 16))
                                .foregroundColor(.white)
                                .bold()
                        }
                    })
                    Button(action: {
                        
                        if showScrollList % 2 == 0 {
                            //video list is showing
                            videoContent.getYTVideoContent(videoId: selectedVideoInfo.videoId)
                            videoContent.getYTVideoDuration(videoId: selectedVideoInfo.videoId)
                            withAnimation(.easeIn(duration: 0.2)) {
                                scrollListX += Constants.screenWidth * 0.66
                                scrollListGradientLineX += Constants.screenWidth * 0.66
                            }
                            withAnimation(.easeOut(duration: 0.2)) {
                                videoDetailsX -= Constants.screenWidth * 0.66
                            }
                        }
                        else {
                            //detail list is showing
                            withAnimation(.easeIn(duration: 0.2)) {
                                videoDetailsX += Constants.screenWidth * 0.66
                            }
                            withAnimation(.easeOut(duration: 0.2)) {
                                scrollListX -= Constants.screenWidth * 0.66
                                scrollListGradientLineX -= Constants.screenWidth * 0.66
                            }
                        }
                        showScrollList += 1
                        
                    }, label: {
                        ZStack{
                            Image("ForwardButtonBackground")
                                .resizable()
                                .scaledToFit()
                            Text("Next")
                                .font(Font.system(size: 16))
                                .foregroundColor(.black)
                                .bold()
                        }
                    })
                }
                .frame(width: Constants.screenWidth * 0.33)
                
            }
            .frame(width: Constants.screenWidth * 0.5, height: Constants.screenHeight)
            .position(x: infoVStackX, y: Constants.screenHeight * 0.5)
            
            //gradient line
            Image("GradientLine")
                .resizable()
                .frame(width: Constants.screenHeight * 1.2, height: gradientLineHeight)
                .rotationEffect(Angle(degrees: 285))
                .position(x: scrollListGradientLineX, y: Constants.halfScreenHeight)
            
            //videos
            if searchedCount % 2 == 0 {
                ScrollListElement(imageData: $imageData, selectedVideoInfo: $selectedVideoInfo)
                    .position(x: scrollListX, y: detectPosition)
                    .onAppear{
                        imageData = Data()
                    }
            }
            else {
                ScrollListElement(imageData: $imageData, selectedVideoInfo: $selectedVideoInfo)
                    .position(x: scrollListX, y: detectPosition)
                    .onAppear{
                        imageData = Data()
                    }
            }
            
            VideoDetailsView(title: selectedVideoInfo.videoName, channel: selectedVideoInfo.channelName, duration: videoContent.ytVideoDuration.duration, published: videoContent.ytVideoContent.published, description: videoContent.ytVideoContent.description, width: Constants.screenWidth * 0.4, fontSize: 16)
                .position(x: videoDetailsX, y: Constants.screenHeight * 0.5)
    
        }
    }
}

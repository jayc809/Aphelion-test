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
    @State var showScrollList = true
    @State var scrollListX = Constants.screenWidth * 0.74
    @State var scrollListGradientLineX = Constants.screenWidth * 0.97
    @State var videoDetailsX = Constants.screenWidth * 1.425
    @State var refresh = 0
    
    let infoVStackX = Constants.screenWidth * 0.29
    let infoWidth = Constants.screenWidth * 0.47
    let thumbnailWidth = Constants.screenWidth * 0.44
    let gradientLineHeight: CGFloat = 20
    
    var body: some View {
        GeometryReader { geometry in 
            ZStack {
                
                //background
                LoopVideo()
                    .frame(width: Constants.screenWidth, height: Constants.screenHeight)
                    .ignoresSafeArea()
                
                VideoDetailsView(title: selectedVideoInfo.videoName, channel: selectedVideoInfo.channelName, duration: getYTDuration(durationString: videoContent.ytVideoDuration.duration) , published: videoContent.ytVideoContent.published, description: videoContent.ytVideoContent.description, width: Constants.screenWidth * 0.4, fontSize: 16, refresh: $refresh)
                    .position(x: videoDetailsX, y: Constants.screenHeight * 0.5)
                
                //info stack
                VStack {
                    //search bar
                    SearchBarElement(searchedCount: $searchedCount, width: infoWidth, fontSize: 20)
                    
                    //thumbnail and high score
                    ZStack {
                        //thumbnail
                        ThumbnailElement(imageData: imageData, imageWidth: thumbnailWidth)
                            .offset(x: (infoWidth - thumbnailWidth) / 2 - 2)
                        
                        //high score
                        HighScoreElement(highScore: 89320, tier: "A", fontSize: 18, width: Constants.screenWidth * 0.3, fullCombo: "")
                            .position(x: infoWidth * 0.22, y: infoWidth * 9 / 16 + gradientLineHeight)
                            .hueRotation(determineHue(combo: 0))
                            
                    }
                    .frame(width: infoWidth, height: infoWidth * 9 / 16 + gradientLineHeight)
                    .padding(.bottom, gradientLineHeight * 1.5)
                    
                    //back next buttons
                    HStack(spacing: 2) {
                        //back
                        Button(action: {
                            
                            if showScrollList == false {
                                //detail list is showing
                                withAnimation(.easeIn(duration: 0.2)) {
                                    videoDetailsX += Constants.screenWidth * 0.66
                                }
                                withAnimation(.easeOut(duration: 0.2)) {
                                    scrollListX -= Constants.screenWidth * 0.66
                                    scrollListGradientLineX -= Constants.screenWidth * 0.66
                                }
                                showScrollList = true
                            }
                            
                        }, label: {
                            ZStack{
                                Image("BackButtonBackground")
                                    .resizable()
                                    .scaledToFit()
                                Text("Back")
                                    .font(Font.system(size: 18))
                                    .foregroundColor(.white)
                                    .bold()
                                    .offset(x: 2)
                            }
                        })
                        //next / play
                        Button(action: {
                            
                            if showScrollList == true && selectedVideoInfo.videoId != "" {
                                refresh += 1
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
                                showScrollList = false
                            }
                            
                        }, label: {
                            ZStack{
                                Image("ForwardButtonBackground")
                                    .resizable()
                                    .scaledToFit()
                                Text(showScrollList == true ? "Next" : "Play")
                                    .font(Font.system(size: 18))
                                    .foregroundColor(.black)
                                    .bold()
                                    .offset(x: -5)
                            }
                        })
                    }
                    .frame(width: Constants.screenWidth * 0.38)
                    
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
                        .hueRotation(determineHue(combo: 0))
                }
                else {
                    ScrollListElement(imageData: $imageData, selectedVideoInfo: $selectedVideoInfo)
                        .position(x: scrollListX, y: detectPosition)
                        .onAppear{
                            imageData = Data()
                        }
                        .hueRotation(determineHue(combo: 0))
                }
        
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

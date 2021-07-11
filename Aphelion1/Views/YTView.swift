//
//  YTView.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/9.
//

import SwiftUI

var searchWord = "suisei song"

struct YTView: View {
    
    @StateObject var model = YTModel()
    @State var searchKeyword = ""
    @State var imageData = Data()
    @State var detectPosition: CGFloat!
    @State var selectedVideoInfo: YTVideoInfo!
    let selectedMultiplier: CGFloat = 1.5
    
    var body: some View {
       
        ZStack {
            
            //video info
            VStack {
                
                Spacer()
                Spacer()
                
                ThumbnailElement(imageData: imageData, imageWidth: Constants.screenWidth * 0.3)
                    
                Spacer()
                
                Text("Difficulty: Easy")
                Text("Tile Speed: 5")
                Text("Score Multiplier: 150%")
                
                Spacer()
                
                PlayButton()

            }
            .frame(width: Constants.halfScreenWidth, height: Constants.screenHeight)
            //.border(Color.blue)
            .position(x: Constants.halfScreenWidth / 2, y: Constants.halfScreenHeight)
            
            //video list
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(Array(model.ytVideoInfos.enumerated()), id:\.offset) { index, ytVideoInfo in
                        VStack {
                            ZStack {
                                //background
                                Image("PauseMenu")
                                    .resizable()
                                //text
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(ytVideoInfo.videoName)
                                        .font(Font.system(size: 15))
                                        .lineLimit(1)
                                    Text("- \(ytVideoInfo.channelName)")
                                        .font(Font.system(size: 10))
                                        .lineLimit(1)
                                }
                                .frame(width: Constants.screenWidth * 0.3 - 35, alignment: .leading)
                                .foregroundColor(.white)
                            }
                            .frame(width: Constants.screenWidth * 0.3, height: 45)
                        }
                        .scaleEffect(selectedVideoInfo != nil && selectedVideoInfo.videoId == ytVideoInfo.videoId  ? selectedMultiplier : 1)
                        .frame(
                            width: selectedVideoInfo != nil && selectedVideoInfo.videoId == ytVideoInfo.videoId  ? Constants.screenWidth * 0.3 * selectedMultiplier : Constants.screenWidth * 0.3,
                            height: selectedVideoInfo != nil && selectedVideoInfo.videoId == ytVideoInfo.videoId  ? 45 * selectedMultiplier : 45
                        )
                        .padding(10)
                        .getPosition { position in
                            
                            model.ytVideoInfos[index].position = position
                            
                            if ytVideoInfo.position.maxY >= detectPosition && ytVideoInfo.position.minY <= detectPosition {
                                withAnimation(.easeOut (duration: 0.1)) {
                                    selectedVideoInfo = ytVideoInfo
                                    imageData = YTVideoProcess(ytVideoInfo: ytVideoInfo).thumbnailData
                                }
                            }
                        
                            if model.ytVideoInfos.first!.position.minY > detectPosition || model.ytVideoInfos.last!.position.maxY < detectPosition {
                                withAnimation(.easeOut (duration: 0.1)) {
                                    selectedVideoInfo = nil
                                }
                            }
                            
                        }
                        .rotationEffect(Angle(degrees: -15))
                    }
                }
                .padding(.vertical, detectPosition)
            }
            .frame(width: Constants.screenWidth, height: Constants.screenHeight * 1.4)
            .getPosition { position in
                detectPosition = (position.minY + position.maxY) * 0.5
            }
            .rotationEffect(Angle(degrees: 15))
            .position(x: Constants.screenWidth * 0.75, y: Constants.screenHeight * 0.55)
            
            //search bar
            TextField(
                "Search",
                text: $searchKeyword,
                onCommit: {
                    searchWord = searchKeyword
                    model.getYTVideoInfos()
                }
            )
            .frame(width: Constants.screenWidth * 0.4, height: 30)
            .position(x: Constants.screenWidth * 0.2, y: 20)
            
        }
        .padding()
        
    }
    
}

struct PositionKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {}
}

extension View {
    func getPosition (_ perform: @escaping (CGRect) ->()) -> some View {
        overlay(GeometryReader { geo in
            Color.clear
                .preference(key: PositionKey.self, value: geo.frame(in: .global))
        }.onPreferenceChange(PositionKey.self, perform: perform))
    }
}

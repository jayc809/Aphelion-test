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
    let rowWidth: CGFloat = Constants.screenWidth * 0.37
    var rowContentWidth: CGFloat {
        return rowWidth - (rowWidth * 360 / 1800 * 0.536) - 14
    }
    let selectedMultiplier: CGFloat = 1.25
    var selectedOffset: CGFloat {
        return 0 - (selectedMultiplier - 1) / 2 * rowWidth + 2.5
    }
    @State var confirmed = false
    
    var body: some View {
       
        ZStack {
            
            //video info
            VStack {
                
                Spacer()
                Spacer()
                
                ThumbnailElement(imageData: imageData, imageWidth: Constants.screenWidth * 0.28)
                    
                Spacer()
                
                Text("Difficulty: Easy")
                Text("Tile Speed: 5")
                Text("Score Multiplier: 150%")
                
                Spacer()
                
                Button {
                    confirmed = true
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(width: 180, height: 180 * 0.15)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        
                        Text("Confirm")
                            .bold()
                            .foregroundColor(.black)
                    }
                }
                
                Spacer()

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
                                Image(selectedVideoInfo != nil && selectedVideoInfo.videoId == ytVideoInfo.videoId ? "YTRowSelected" : "YTRow")
                                    .resizable()
                                    .scaledToFit()
                                //text
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(ytVideoInfo.videoName)
                                        .font(Font.system(size: 14))
                                        .lineLimit(1)
                                    Text("- \(ytVideoInfo.channelName)")
                                        .font(Font.system(size: 10))
                                        .lineLimit(1)
                                        .offset(x: -10)
                                }
                                .frame(width: rowContentWidth, alignment: .leading)
                                .offset(x: 10)
                                .foregroundColor(selectedVideoInfo != nil && selectedVideoInfo.videoId == ytVideoInfo.videoId ? .black : .white)
                            }
                            .frame(width: rowWidth)
                        }
                        .scaleEffect(selectedVideoInfo != nil && selectedVideoInfo.videoId == ytVideoInfo.videoId ? selectedMultiplier : 1)
                        .frame(width: selectedVideoInfo != nil && selectedVideoInfo.videoId == ytVideoInfo.videoId ? rowWidth * (selectedMultiplier * 2 - 1) : rowWidth)
                        .padding(10)
                        .offset(x: selectedVideoInfo != nil && selectedVideoInfo.videoId == ytVideoInfo.videoId ? selectedOffset : 0)
                        .getPosition { position in
                            
                            model.ytVideoInfos[index].position = position
                            
                            if ytVideoInfo.position.maxY >= detectPosition && ytVideoInfo.position.minY <= detectPosition {
                                imageData = YTVideoProcess(ytVideoInfo: ytVideoInfo).thumbnailData
                                withAnimation(.easeOut (duration: 0.1)) {
                                    selectedVideoInfo = ytVideoInfo
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
                .padding(.vertical, Constants.screenHeight * 0.6)
            }
            .frame(width: Constants.screenWidth, height: Constants.screenHeight * 1.4)
            .getPosition { position in
                detectPosition = (position.minY + position.maxY) * 0.5
            }
            .rotationEffect(Angle(degrees: 15))
            .position(x: Constants.screenWidth * 0.73, y: Constants.screenHeight * 0.53)
            
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
            //.border(Color.green)
            .position(x: Constants.screenWidth * 0.5, y: Constants.screenHeight * 0.5)
            
            if confirmed {
                YTConfirmationView(videoName: selectedVideoInfo.videoName, channelName: selectedVideoInfo.channelName, imageData: imageData)
            }
            
        }
        
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

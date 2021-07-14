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
    @State var imageData = Data()
    @State var detectPosition = Constants.screenHeight * 0.55
    let rowWidth: CGFloat = Constants.screenWidth * 0.395
    var rowContentWidth: CGFloat {
        return rowWidth - (rowWidth * 360 / 1800 * 0.536) - 15
    }
    @State var selectedVideoInfo = YTVideoInfo()
    let selectedMultiplier: CGFloat = 1.25
    var selectedOffset: CGFloat {
        return 0 - (selectedMultiplier - 1) / 2 * rowWidth + 2.5
    }
    @State var confirmed = false
    @State var searchedCount = 0
    
    var body: some View {
       
        ZStack {
            
            //gradient line
            Image("GradientLine")
                .resizable()
                .frame(width: Constants.screenHeight * 1.2, height: 10)
                .rotationEffect(Angle(degrees: 285))
                .position(x: Constants.screenWidth * 0.963, y: Constants.halfScreenHeight)
            
            //video info
            HStack {
                Spacer()
                //thumbnail
                VStack(spacing: 0) {
                    ThumbnailElement(imageData: imageData, imageWidth: Constants.screenWidth * 0.3)
                    Image("GradientLine")
                        .resizable()
                        .frame(width: Constants.screenWidth * 0.3, height: 10)
                }
                .padding(.trailing, 2)
            }
            .position(x: 0, y: Constants.screenHeight * 0.42)
            
            //high score
            HStack {
                Spacer()
                HighScoreElement(highScore: 89320, tier: "S", fontSize: 13, width: Constants.screenWidth * 0.22, fullCombo: "")
                    .offset(x: -Constants.screenWidth * 0.275)
            }
            .position(x: 0, y: Constants.screenHeight * 0.46)
            
            //video list
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(Array(model.ytVideoInfos.enumerated()), id:\.offset) { index, ytVideoInfo in
                        VStack {
                            ZStack {
                                //background
                                Image(selectedVideoInfo.videoId == ytVideoInfo.videoId ? "YTRowSelected" : "YTRow")
                                    .resizable()
                                    .scaledToFit()
                                //text
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(ytVideoInfo.videoName)
                                        .font(Font.system(size: 15))
                                        .bold()
                                        .lineLimit(1)
                                    Text("- \(ytVideoInfo.channelName)")
                                        .font(Font.system(size: 10))
                                        .lineLimit(1)
                                        .offset(x: -10)
                                }
                                .frame(width: rowContentWidth, alignment: .leading)
                                .offset(x: 10)
                                .foregroundColor(selectedVideoInfo.videoId == ytVideoInfo.videoId ? .black : .white)
                            }
                            .frame(width: rowWidth)
                        }
                        .scaleEffect(selectedVideoInfo.videoId == ytVideoInfo.videoId ? selectedMultiplier : 1)
                        .frame(width: selectedVideoInfo.videoId == ytVideoInfo.videoId ? rowWidth * (selectedMultiplier * 2 - 1) : rowWidth)
                        .offset(x: selectedVideoInfo.videoId == ytVideoInfo.videoId ? selectedOffset : 0)
                        .padding(10)
                        .getPosition { position in

                            model.ytVideoInfos[index].position = position

                            if ytVideoInfo.position.maxY >= detectPosition && ytVideoInfo.position.minY <= detectPosition {
                                imageData = YTVideoProcess(ytVideoInfo: ytVideoInfo).thumbnailData
                                withAnimation(.easeOut (duration: 0.1)) {
                                    selectedVideoInfo = ytVideoInfo
                                }
                            }

                        }
                        .rotationEffect(Angle(degrees: -15))
                    }
                }
                .padding(.vertical, Constants.screenHeight * 0.6)
            }
            .frame(width: Constants.screenWidth, height: Constants.screenHeight * 1.4)
            .rotationEffect(Angle(degrees: 15))
            .position(x: Constants.screenWidth * 0.74, y: detectPosition)
//
            //search bar
            VStack {
                SearchBarElement(searchedCount: $searchedCount, width: Constants.screenWidth * 0.42, fontSize: 16, offset: 1.5)
                    .onChange(of: searchedCount, perform: { value in
                        model.getYTVideoInfos()
                    })
                Image("GradientLine")
                    .resizable()
                    .frame(width: Constants.screenWidth * 0.42, height: 10)
                    .offset(y: -6)
            }
            .position(x: Constants.screenWidth * 0.29 - 2, y: Constants.screenHeight * 0.14)
            
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

//
//  ScrollListElement.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/15.
//

import SwiftUI

struct ScrollListElement: View {
    
    @StateObject var model = YTModel()
    @Binding var imageData: Data
    @Binding var selectedVideoInfo: YTVideoInfo
    let rowWidth: CGFloat = Constants.screenWidth * 0.395
    var rowContentWidth: CGFloat {
        return rowWidth - (rowWidth * 360 / 1800 * 0.536) - 15
    }
    let selectedMultiplier: CGFloat = 1.25
    var selectedOffset: CGFloat {
        return 0 - (selectedMultiplier - 1) / 2 * rowWidth + 2.5
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                ForEach(Array(model.ytVideoInfos.enumerated()), id:\.offset) { index, ytVideoInfo in
                    VStack {
                        ZStack {
                            //background
                            Image(selectedVideoInfo.videoId == ytVideoInfo.videoId ? "YTRowSelected" : "YTRowGradient")
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
            .padding(.vertical, Constants.screenHeight * 0.65)
        }
        .frame(width: Constants.screenWidth, height: Constants.screenHeight * 1.4)
        .rotationEffect(Angle(degrees: 15))
    }
}

struct ScrollListPreview: View {
    
    @State var imageData = Data()
    @State var selectedVideoInfo = YTVideoInfo()
    @State var searchedCount = 0
    
    var body: some View {
        ZStack {
            ScrollListElement(imageData: $imageData, selectedVideoInfo: $selectedVideoInfo)
        }
    }
}

struct ScrollListElement_Previews: PreviewProvider {
    static var previews: some View {
        ScrollListPreview()
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


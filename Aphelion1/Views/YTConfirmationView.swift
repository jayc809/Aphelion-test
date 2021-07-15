//
//  YTConfirmationView.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/12.
//

import SwiftUI

struct YTConfirmationView: View {
    
    var videoName: String
    var channelName: String
    var imageData: Data
    
    var body: some View {
        
        ZStack {
            
            Rectangle()
                .frame(width: Constants.screenWidth, height: Constants.screenHeight)
                .foregroundColor(.black)
                .opacity(0.85)
            
            ZStack {
                
                Image("PauseMenu")
                    .resizable()
                GeometryReader { geometry in
                    
                    ThumbnailElement(imageData: imageData, imageWidth: Constants.screenWidth * 0.2)
                        .position(x: geometry.size.width * 0.25 , y: geometry.size.height * 0.42)
                        
                    VStack(spacing: 10) {
                        
                        Text(videoName)
                            .font(Font.system(size: 15))
                            .lineLimit(2)
                        
                        HStack {
                            
                            Text("- \(channelName)")
                                .font(Font.system(size: 12))
                                .lineLimit(1)
                                .padding(.leading, 25)
                            
                            Spacer()
                            
                            Text("04:13")
                                .font(Font.system(size: 12))
                                .lineLimit(1)
                                .padding(.trailing, 25)
                            
                        }
                        
                    }
                    .frame(width: Constants.screenWidth * 0.32, height: Constants.screenWidth * 0.2 * 9 / 16)
                    .position(x: geometry.size.width * 0.705 , y: geometry.size.height * 0.42)
                    
                    
                    PlayButton(width: 150)
                        .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.83)
                    
                }
                
            }
            .frame(width: Constants.screenWidth * 0.6, height: Constants.screenHeight * 0.4)
            .foregroundColor(.white)
            
        }
        .frame(width: Constants.screenWidth, height: Constants.screenHeight)
        
    }
}

struct YTConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        return YTConfirmationView(videoName: YTVideoInfo().videoName, channelName: YTVideoInfo().channelName, imageData: YTVideoProcess(ytVideoInfo: YTVideoInfo()).thumbnailData).previewLayout(.fixed(width: Constants.screenWidth, height: Constants.screenHeight))
    }
}

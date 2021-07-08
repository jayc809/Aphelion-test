//
//  YTCard.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/9.
//

import SwiftUI

struct YTCard: View {
    
    @State var ytVideoInfo: YTVideoInfo
    @State var imageHeight: CGFloat = 0
    
    var body: some View {
        
        Button(action: {
            
        }, label: {
            ZStack {
                
                Image("PauseMenu")
                    .resizable()
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text(ytVideoInfo.videoName)
                        .font(Font.system(size: 15))
                    
                    Text(ytVideoInfo.channelName)
                        .font(Font.system(size: 10))
                    
                }
                
            }
            .foregroundColor(.white)
            .frame(width: Constants.screenWidth * 0.4, height: 70)
        })
        
    }
}

struct YTCard_Previews: PreviewProvider {
    static var previews: some View {
        return YTCard(ytVideoInfo: YTVideoInfo()).previewLayout(.fixed(width: Constants.screenWidth, height: Constants.screenHeight))
    }
}
//
//  YTThumbnail.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/11.
//

import SwiftUI

struct ThumbnailElement: View {
    
    var imageData: Data
    var imageWidth: CGFloat
    
    var body: some View {
        
        ZStack {
            Image(uiImage: UIImage(data: imageData) ?? UIImage())
                .resizable()
                .scaledToFill()
                .frame(width: imageWidth, height: imageWidth * 9 / 16)
                .background(Color.black)
            Image("ThumbnailFrameGradient")
                .resizable()
                .scaledToFit()
        }
        .frame(width: imageWidth * 1650 / 1600, height: imageWidth * 1650 / 1600 * 9 / 16)
        .clipped()
        
    }
}

struct ThumbnailElement_Previews: PreviewProvider {
    static var previews: some View {
        ThumbnailElement(imageData: YTVideoProcess(ytVideoInfo: YTVideoInfo(test: "")).thumbnailData, imageWidth: Constants.screenWidth * 0.3)
    }
}

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
        
        Image(uiImage: UIImage(data: imageData) ?? UIImage())
            .resizable()
            .scaledToFill()
            .frame(width: imageWidth, height: imageWidth * 9 / 16)
            .clipped()
            .border(Color.white)
        
    }
}

struct ThumbnailElement_Previews: PreviewProvider {
    static var previews: some View {
        ThumbnailElement(imageData: YTVideoProcess(ytVideoInfo: YTVideoInfo()).thumbnailData, imageWidth: Constants.screenWidth * 0.3)
    }
}

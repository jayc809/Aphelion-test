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
    var videoId: String
    @Binding var previewAudio: Bool
    @Binding var _brightness: Double
    @Binding var _saturation: Double
    
    var body: some View {
        
        ZStack {
            if previewAudio == false {
                Image(uiImage: UIImage(data: imageData) ?? UIImage())
                    .interpolation(.none)
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageWidth, height: imageWidth * 9 / 16)
                    .background(Color.black)
                    .brightness(_brightness)
                    .saturation(_saturation)
            }
            else {
                YTAudioPreview(videoId: videoId, previewAudio: $previewAudio)
                    .frame(width: imageWidth, height: imageWidth * 9 / 16)
                    .background(Color.black)
                    .brightness(_brightness)
                    .saturation(_saturation)
            }
            
            Image("ThumbnailFrameGradient")
                .resizable()
                .scaledToFit()
        }
        .frame(width: imageWidth * 1650 / 1600, height: imageWidth * 1650 / 1600 * 9 / 16)
        .clipped()
        
    }
}

struct YTAudioPreview: View {

    var videoId: String
    @State var timer = Timer.publish(every: 0.1, on: .current, in: .common).autoconnect()
    @State var opacity: Double = 1
    @Binding var previewAudio: Bool

    var body: some View {
        let ytManager = YTManager(videoID: videoId, preview: true)
        ZStack {
            YTRepresented(player: ytManager.player)
                .onReceive(timer, perform: { _ in
                    ytManager.player.videoLoadedFraction { fraction, error in
                        
                        if opacity == 0 {
                            withAnimation(.easeOut(duration: 0.5)) {
                                previewAudio = false
                            }
                        }
                        
                        if fraction >= 0.05 {
                            timer = Timer.publish(every: 29, on: .current, in: .common).autoconnect()
                            withAnimation(.easeIn(duration: 0.7).delay(2)) {
                                opacity = 0
                            }
                        }
                        else if fraction >= 0 {
                            ytManager.play()
                        }
                    }
                })
                .allowsHitTesting(false)
            Rectangle()
                .foregroundColor(.black)
                .scaledToFill()
                .opacity(opacity)
        }
    }
}
//
//
//struct ThumbnailElement_Previews: PreviewProvider {
//    static var previews: some View {
//        ThumbnailElement(imageData: YTVideoProcess(ytVideoInfo: YTVideoInfo(test: "")).thumbnailData, imageWidth: Constants.screenWidth * 0.3)
//    }
//}

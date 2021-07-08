//
//  YoutubeCard.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/9.
//

import SwiftUI

struct YoutubeCard: View {
    
    @ObservedObject var videoPreview: VideoPreview
    @State private var imageHeight: CGFloat = 0
    
    var body: some View {
            Button(action: {
            }) {
                VStack(alignment: .leading, spacing: 10) {
                    
                    GeometryReader { geometry in
                        
                        // Create an image from the video preview's data
                        Image(uiImage: UIImage(data: videoPreview.thumbnailData) ?? UIImage())
                            .resizable()
                            .scaledToFill()
                            // Set the aspect ratio for the view to be 16 : 9
                            .frame(width: geometry.size.width, height: geometry.size.width * 9 / 16)
                            .clipped()
                            .onAppear {
                                // Update the height of the image
                                imageHeight = geometry.size.width * 9 / 16
                            }
                    }
                    // We set the height explicitly so the geometry reader's proposed height is not collapsed
                    .frame(height: imageHeight)
                    
                    // Display the video's title
                    Text(videoPreview.title)
                        .bold()
                    
                    // Display the video's date
                    Text(videoPreview.video.videoId)
                }
                .font(.system(size: 19))
            }
    }
}

//
//struct YoutubeCard_Previews: PreviewProvider {
//    static var previews: some View {
//        YoutubeCard()
//    }
//}

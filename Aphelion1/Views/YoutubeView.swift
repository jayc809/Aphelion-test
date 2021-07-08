//
//  YoutubeHomeView.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/6.
//

import SwiftUI



struct YoutubeView: View {
    
    @StateObject var model = VideoModel()
    @State var searchKeyword = ""
    
    var body: some View {
        
        VStack {
            //search bar
            TextField("Search",
                      text: $searchKeyword,
                      onCommit: {
                            //searchWord = searchKeyword
                      }
            )
            //video list
            ScrollView {
                LazyVStack {
                    ForEach(model.videos, id:\.videoId) { video in
                        YoutubeCard(videoPreview: VideoPreview(video: video))
                            .padding()
                    }
                }
                .padding(.top, 10)
            }
        }
        .foregroundColor(.white)
        .animation(.easeOut)
    }
    
}

struct YoutubeView_Previews: PreviewProvider {
    static var previews: some View {
        return YoutubeView().previewLayout(.fixed(width: Constants.screenWidth, height: Constants.screenHeight))
    }
}

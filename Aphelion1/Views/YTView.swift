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
    let imageWidth = Constants.screenWidth * 0.3
    @State var refresh = false
    
    var body: some View {
       
        VStack {
            
            //search bar
            TextField(
                "Search",
                text: $searchKeyword,
                onCommit: {
                    searchWord = searchKeyword
                    model.getYTVideoInfos()
                }
            )
            
            //videos
            HStack {
            
                Image(uiImage: UIImage(data: imageData) ?? UIImage())
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageWidth, height: imageWidth * 9 / 16)
                
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 20) {
                        ForEach(model.ytVideoInfos, id:\.videoId) { ytVideoInfo in
                            YTCard(ytVideoInfo: ytVideoInfo)
                                //.rotationEffect(Angle(degrees: -15))
                        }
                    }
                }
                //.rotationEffect(Angle(degrees: 15))
            }
            
        }
        .padding()
        
    }
    
}

struct YTView_Previews: PreviewProvider {
    static var previews: some View {
        YTView()
    }
}

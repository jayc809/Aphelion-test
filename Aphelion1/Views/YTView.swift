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
    
    var body: some View {
       
        VStack {
            
            //search bar
            TextField(
                "Search",
                text: $searchKeyword,
                onCommit: {
                    searchWord = searchKeyword
                }
            )
            
            //videos
            HStack {
                ScrollView {
                    LazyVStack {
                        ForEach(model.ytVideoInfos, id:\.videoId) { ytVideoInfo in
                            YTCard(ytVideoInfo: ytVideoInfo)
                        }
                    }
                }
            }
            
        }
        
    }
}

struct YTView_Previews: PreviewProvider {
    static var previews: some View {
        YTView()
    }
}

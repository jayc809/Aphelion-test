//
//  YoutubeHomeView.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/6.
//

import SwiftUI

struct YoutubeView: View {
    
    @State var searchKeyword = ""
    
    var body: some View {
        TextField("Search",
                  text: $searchKeyword,
                  onCommit: {
                        
                  }
        )
    }
}

struct YoutubeView_Previews: PreviewProvider {
    static var previews: some View {
        return YoutubeView().previewLayout(.fixed(width: Constants.screenWidth, height: Constants.screenHeight))
    }
}

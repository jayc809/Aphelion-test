//
//  SearchBarElement.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/14.
//

import SwiftUI

struct SearchBarElement: View {
    
    @Binding var searchedCount: Int
    @State var searchKeyword = ""
    @State var showYTLogo = true
    var width: CGFloat
    var height: CGFloat {
        return width * 0.125
    }
    var fontSize: CGFloat
    let padding: CGFloat = 5
    
    var body: some View {
        
        ZStack {
            
            VStack {
                Spacer()
                Image("SearchBarBackgroundGradient")
                    .resizable()
                    .scaledToFit()
            }
                    
            ZStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .frame(width: fontSize)
                        .padding(.trailing, padding * 1.5)
                    
                    ZStack(alignment: .leading) {
                        if showYTLogo {
                            HStack {
                                //text showing
                                Text("Search")
                                    .font(Font.system(size: fontSize))
                                    .padding(.trailing, padding * 0.3)
                                Image("yt_logo_mono_dark")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: fontSize)
                                Spacer()
                            }
                        }
                        //text input
                        TextField(
                            "",
                            text: $searchKeyword,
                            onCommit: {
                                searchWord = searchKeyword
                                searchedCount += 1
                            }
                        )
                        .onChange(of: searchKeyword, perform: { value in
                            if searchKeyword == "" {
                                showYTLogo = true
                            }
                            else {
                                showYTLogo = false
                            }
                        })
                        .font(Font.system(size: fontSize))
                        .lineLimit(1)
                        .frame(height: height)
                    }
                }
                .padding(.leading, padding)
            }
            
        }
        .frame(width: width, height: height)
    }
}

struct SearchBarPreview: View {
    @State var searchedCount = 0
    var body: some View {
        SearchBarElement(searchedCount: $searchedCount, width: 300, fontSize: 20)
    }
}

struct SearchBarPreview_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarPreview()
    }
}

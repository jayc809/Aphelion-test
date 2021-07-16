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
        return width * 0.113
    }
    var fontSize: CGFloat
    var offset: CGFloat
    
    var body: some View {
        
        ZStack {
            
            if showYTLogo {
                HStack(spacing: fontSize / 2) {
                    Text("Search")
                        .font(Font.system(size: fontSize))
                        .offset(y: offset)
                    Image("yt_logo_mono_dark")
                        .resizable()
                        .scaledToFit()
                        .frame(height: fontSize)
                    Spacer()
                }
                .padding(.leading, 7)
            }
            
            HStack {
                Spacer()
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .padding(7)
                    .scaledToFit()
            }
            
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
            .frame(height: height)
            .padding(.leading, 7)
            
        }
        .frame(width: width, height: height)
    }
}


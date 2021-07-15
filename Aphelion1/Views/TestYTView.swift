//
//  TestYTView.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/15.
//

import SwiftUI

struct TestYTView: View {
    
    @State var imageData = YTVideoProcess(ytVideoInfo: YTVideoInfo(test: "")).thumbnailData
    @State var searchedCount = 0
    
    let thumbnailWidth = Constants.screenWidth * 0.47
    let gradientLineHeight: CGFloat = 10
    
    var body: some View {
        
        ZStack {
            
            Image("test_star_background")
                .resizable()
            
            VStack {
                
                //search bar
                VStack {
                    SearchBarElement(searchedCount: $searchedCount, width: thumbnailWidth, fontSize: 18, offset: 0)
                    Image("GradientLine")
                        .resizable()
                        .frame(width: thumbnailWidth, height: gradientLineHeight)
                        .offset(y: -6)
                }
                
                //thumbnail and high score
                ZStack {
                    //thumbnail
                    ZStack {
                        VStack(spacing: 0) {
                            ThumbnailElement(imageData: imageData, imageWidth: thumbnailWidth)
                            Image("GradientLine")
                                .resizable()
                                .frame(width: thumbnailWidth, height: gradientLineHeight)
                        }
                    }
                    
                    //high score
                    HighScoreElement(highScore: 89320, tier: "A", fontSize: 15, width: Constants.screenWidth * 0.25, fullCombo: "")
                        .position(x: thumbnailWidth * 0.17, y: thumbnailWidth * 9 / 16 + gradientLineHeight * 1.5)
                        
                }
                .frame(width: thumbnailWidth, height: thumbnailWidth * 9 / 16 + gradientLineHeight)
                .padding(.bottom, gradientLineHeight * 3)
                .padding(.vertical,gradientLineHeight)
                
                //confirm button
                ConfirmButton(fontSize: 18, width: Constants.screenWidth * 0.24)
                
            }
            .frame(width: Constants.screenWidth * 0.5, height: Constants.screenHeight)
            //.border(Color.green)
            .position(x: Constants.screenWidth * 0.29, y: Constants.screenHeight * 0.5)
            
            Image("GradientLine")
                .resizable()
                .frame(width: Constants.screenHeight * 1.2, height: 10)
                .rotationEffect(Angle(degrees: 285))
                .position(x: Constants.screenWidth * 0.963, y: Constants.halfScreenHeight)
            
            Image("rows")
                .resizable()
                .scaledToFit()
                .position(x: Constants.screenWidth * 0.723, y: Constants.halfScreenHeight)
            
        }
    }
}

struct TestYTView_Previews: PreviewProvider {
    static var previews: some View {
        TestYTView().previewLayout(.fixed(width: Constants.screenWidth, height: Constants.screenHeight))
    }
}

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
    
    let infoWidth = Constants.screenWidth * 0.47
    let thumbnailWidth = Constants.screenWidth * 0.41
    let gradientLineHeight: CGFloat = 20
    
    var body: some View {
        
        ZStack {
            
            Image("test_star_background")
                .resizable()
            
            VStack {
                
                //search bar
                VStack {
                    SearchBarElement(searchedCount: $searchedCount, width: infoWidth, fontSize: 18, offset: 0)
                    Image("GradientLine")
                        .resizable()
                        .frame(width: infoWidth, height: gradientLineHeight)
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
                    .offset(x: (infoWidth - thumbnailWidth) / 2 - 2)
                    
                    
                    //high score
                    HighScoreElement(highScore: 89320, tier: "A", fontSize: 18, width: Constants.screenWidth * 0.3, fullCombo: "")
                        .position(x: infoWidth * 0.2, y: infoWidth * 9 / 16 + gradientLineHeight)
                        
                }
                .frame(width: infoWidth, height: infoWidth * 9 / 16 + gradientLineHeight)
                .padding(.bottom, gradientLineHeight * 1.5)
                
                //back next buttons
                HStack(spacing: 0) {
                    Button(action: {
                        
                    }, label: {
                        ZStack{
                            Image("BackButtonBackground")
                                .resizable()
                                .scaledToFit()
                            Text("Back")
                                .font(Font.system(size: 16))
                                .foregroundColor(.white)
                                .bold()
                        }
                    })
                    Button(action: {
                        
                    }, label: {
                        ZStack{
                            Image("ForwardButtonBackground")
                                .resizable()
                                .scaledToFit()
                            Text("Next")
                                .font(Font.system(size: 16))
                                .foregroundColor(.black)
                                .bold()
                        }
                    })
                }
                .frame(width: Constants.screenWidth * 0.33)
                
            }
            .frame(width: Constants.screenWidth * 0.5, height: Constants.screenHeight)
            //.border(Color.green)
            .position(x: Constants.screenWidth * 0.29, y: Constants.screenHeight * 0.5)
            
            Image("GradientLine")
                .resizable()
                .frame(width: Constants.screenHeight * 1.2, height: gradientLineHeight)
                .rotationEffect(Angle(degrees: 285))
                .position(x: Constants.screenWidth * 0.97, y: Constants.halfScreenHeight)
            
            Image("WhiteLine")
                .resizable()
                .frame(width: Constants.screenHeight * 1.2, height: 2)
                .rotationEffect(Angle(degrees: 105))
                .position(x: Constants.screenWidth - 15, y: Constants.screenHeight)
            
            Image("WhiteLine")
                .resizable()
                .frame(width: Constants.screenHeight * 1.2, height: 2)
                .rotationEffect(Angle(degrees: 105))
                .position(x: Constants.screenWidth - 30, y: Constants.screenHeight)
            
            Image("WhiteLine")
                .resizable()
                .frame(width: Constants.screenHeight * 1.2, height: 2)
                .rotationEffect(Angle(degrees: 105))
                .position(x: 15, y: 0)
            
            Image("WhiteLine")
                .resizable()
                .frame(width: Constants.screenHeight * 1.2, height: 2)
                .rotationEffect(Angle(degrees: 105))
                .position(x: 30, y: 0)
            
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

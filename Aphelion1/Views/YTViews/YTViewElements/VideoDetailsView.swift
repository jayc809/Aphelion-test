//
//  VideoDetailsVideo.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/16.
//

import SwiftUI

struct VideoDetailsView: View {
    
    var title: String
    var channel: String
    var duration: String
    var published: String
    var description: String
    var width: CGFloat
    var fontSize: CGFloat
    
    @State var currModuleName = "Track Details"
    @State var detailsX: CGFloat = 0
    @State var settingsX: CGFloat = 0
    @State var detailsModuleX: CGFloat = 0
    @State var settingsModuleX: CGFloat = 0
    
    let animationLength = 0.2
    var leftTab: CGFloat {
        return -width * 0.7
    }
    var centerTab: CGFloat {
        return width * 0.5
    }
    var rightTab: CGFloat {
        return width * 1.7
    }
    
    var moduleNameWidth: CGFloat {
        return width * 0.5
    }
    var leftModule: CGFloat {
        return -moduleNameWidth * 0.7
    }
    var centerModule: CGFloat {
        return moduleNameWidth * 0.5
    }
    var rightModule: CGFloat {
        return moduleNameWidth * 1.7
    }
    var moduleNameFontSize: CGFloat {
        return fontSize * 1.4
    }
    
    var body: some View {
        
        VStack {
            
            //buttons
            HStack {
                
                Button(action: {
                    if currModuleName == "Track Details" {                        currModuleName = "Settings"
                        settingsX = leftTab
                        settingsModuleX = leftModule
                        detailsX = centerTab
                        detailsModuleX = centerModule
                        withAnimation(.easeOut(duration: 0.2)) {
                            settingsX = centerTab
                            settingsModuleX = centerModule
                            detailsX = rightTab
                            detailsModuleX = rightModule
                        }
                    }
                    else if currModuleName == "Settings" {
                        currModuleName = "Track Details"
                        detailsX = leftTab
                        detailsModuleX = leftModule
                        settingsX = centerTab
                        settingsModuleX = centerModule
                        withAnimation(.easeOut(duration: 0.2)) {
                            detailsX = centerTab
                            detailsModuleX = centerModule
                            settingsX = rightTab
                            settingsModuleX = rightModule
                        }
                    }
                }, label: {
                    Image(systemName: "arrowtriangle.left.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: moduleNameFontSize * 0.6)
                        .foregroundColor(.white)
                        .contentShape(Rectangle())
                })
                
                ZStack {
                    Text("Content")
                        .font(Font.system(size: moduleNameFontSize))
                        .onAppear {
                            detailsModuleX = centerModule
                        }
                        .position(x: detailsModuleX, y: moduleNameFontSize * 0.5)
                    
                    Text("Settings")
                        .font(Font.system(size: moduleNameFontSize))
                        .onAppear {
                            settingsModuleX = leftModule
                        }
                        .position(x: settingsModuleX, y: moduleNameFontSize * 0.5)
                        
                }
                .frame(width: moduleNameWidth, height: moduleNameFontSize)
                .clipped()
                
                Button(action: {
                    
                    if currModuleName == "Settings" {
                        currModuleName = "Track Details"
                        detailsX = rightTab
                        detailsModuleX = rightModule
                        settingsX = centerTab
                        settingsModuleX = centerModule
                        withAnimation(.easeOut(duration: animationLength)) {
                            detailsX = centerTab
                            detailsModuleX = centerModule
                            settingsX = leftTab
                            settingsModuleX = leftModule
                        }
                    }
                    else if currModuleName == "Track Details" {                        currModuleName = "Settings"
                        settingsX = rightTab
                        settingsModuleX = rightModule
                        detailsX = centerTab
                        detailsModuleX = centerModule
                        withAnimation(.easeOut(duration: animationLength)) {
                            settingsX = centerTab
                            settingsModuleX = centerModule
                            detailsX = leftTab
                            detailsModuleX = leftModule
                        }
                    }
                    
                }, label: {
                    Image(systemName: "arrowtriangle.right.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: moduleNameFontSize * 0.6)
                        .foregroundColor(.white)
                        .contentShape(Rectangle())
                })
            }
            .padding(.bottom, 10)
            .padding(.top, 40)
            
            GeometryReader { geometry in
                ZStack {
                    
                    VideoContentView(title: title, channel: channel, duration: duration, published: published, description: description, width: width, fontSize: fontSize)
                        .onAppear {
                            detailsX = centerTab
                        }
                        .position(x: detailsX, y: geometry.size.height * 0.5)
                
                    GameSettingsView(width: width, fontSize: fontSize)
                        .onAppear {
                            settingsX = leftTab
                        }
                        .position(x: settingsX, y: geometry.size.height * 0.5)
                    
                }
            }
        }
        .frame(width: width, height:  Constants.screenHeight)
        .clipped()
    }
}

struct VideoContentView: View {
    
    var title: String
    var channel: String
    var duration: String
    var published: String
    var description: String
    var width: CGFloat
    var fontSize: CGFloat
    
    var body: some View {
        
        let padding = fontSize * 0.3
        
        ScrollView(showsIndicators: false) {
            
            VStack(alignment: .leading) {
                
            Text(title)
                .font(Font.system(size: fontSize * 1.25))
                .padding(.bottom, padding)
                .padding(.top, 10)
            Text("Artist - \(channel)")
                .font(Font.system(size: fontSize))
                .padding(.vertical, padding)
            Text("Duration - \(duration)")
                .font(Font.system(size: fontSize))
                .padding(.vertical, padding)
            Text("Published - \(published)")
                .font(Font.system(size: fontSize))
                .padding(.vertical, padding)
            Text("Description - ")
                .font(Font.system(size: fontSize))
                .padding(.vertical, padding)
            Text(description)
                .font(Font.system(size: fontSize))
            }
        }
        .frame(width: width)
    }
    
}

struct GameSettingsView: View {
    
    var width: CGFloat
    var fontSize: CGFloat
    
    var body: some View {
        
        let gridLayout = [GridItem(.fixed(width * 0.4)), GridItem(.fixed(width * 0.6))]
        let maxFrame = width * 0.4
        let gridSpacing = fontSize * 0.8
        let gridPadding = fontSize * 0.45
        
        ScrollView(showsIndicators: false) {
            
            Text("Gameplay")
                .font(Font.system(size: fontSize * 1.25))
                .padding(.top, 10)
            LazyVGrid(columns: gridLayout, alignment: .leading, spacing: gridSpacing) {
                
                Text("Difficulty")
                    .font(Font.system(size: fontSize))
                    .padding(.leading, gridPadding)
                HStack {
                    Spacer()
                    DifficultyButton(fontSize: fontSize)
                        .frame(width: maxFrame)
                }
                
                Text("Note Speed")
                    .font(Font.system(size: fontSize))
                    .padding(.leading, gridPadding)
                HStack {
                    Spacer()
                    TileSpeedStepper(width: fontSize * 5, height: fontSize + 2, spacing: fontSize * 0.6)
                        .padding(.vertical, -1)
                        .frame(width: maxFrame)
                }
                
                Text("Slide Notes")
                    .font(Font.system(size: fontSize))
                    .padding(.leading, gridPadding)
                HStack {
                    Spacer()
                    SlideNoteButton(fontSize: fontSize)
                        .frame(width: maxFrame)
                }
                
                Text("Divine Boost")
                    .font(Font.system(size: fontSize))
                    .padding(.leading, gridPadding)
                HStack {
                    Spacer()
                    DivineBoostButton(fontSize: fontSize)
                        .frame(width: maxFrame)
                }
            }
            
            Text("Visuals")
                .font(Font.system(size: fontSize * 1.25))
                .padding(.top, 20)
            LazyVGrid(columns: gridLayout, alignment: .leading, spacing: gridSpacing) {
                
                Text("Note Theme")
                    .font(Font.system(size: fontSize))
                    .padding(.leading, gridPadding)
                HStack {
                    Spacer()
                    TileThemeButton(height: fontSize + 5)
                        .padding(.vertical, -2.5)
                        .frame(width: maxFrame)
                        .offset(y: 1.5)
                }
                
                Text("Animation Quality")
                    .font(Font.system(size: fontSize))
                    .padding(.leading, gridPadding)
                HStack {
                    Spacer()
                    AnimationQualityButton(fontSize: fontSize)
                        .frame(width: maxFrame)
                }
                
                Text("Animation Offset")
                    .font(Font.system(size: fontSize))
                    .padding(.leading, gridPadding)
                HStack {
                    Spacer()
                    AnimationOffsetStepper(width: fontSize * 5, height: fontSize + 2, spacing: fontSize * 0.15)
                        .frame(width: maxFrame)
                }
                
                Text("Background")
                    .font(Font.system(size: fontSize))
                    .padding(.leading, gridPadding)
                HStack {
                    Spacer()
                    GameBackgroundButton(fontSize: fontSize)
                        .frame(width: maxFrame)
                }
                
                Text("Brightness & Saturation")
                    .font(Font.system(size: fontSize))
                    .padding(.leading, gridPadding)
                HStack {
                    Spacer()
                    BrightnessAndSaturationButton(arrowWidth: width * 0.05)
                        .frame(width: maxFrame)
                }
            }
            
            Text("Sounds")
                .font(Font.system(size: fontSize * 1.25))
                .padding(.top, 20)
            LazyVGrid(columns: gridLayout, alignment: .leading, spacing: gridSpacing) {
                
                Text("Sound Effects")
                    .font(Font.system(size: fontSize))
                    .padding(.leading, gridPadding)
                HStack {
                    Spacer()
                    SoundEffectsButton(fontSize: fontSize)
                        .frame(width: maxFrame)
                }
                
                Text("Audio Offset")
                    .font(Font.system(size: fontSize))
                    .padding(.leading, gridPadding)
                HStack {
                    Spacer()
                    AudioOffsetStepper(width: fontSize * 5, height: fontSize + 2, spacing: fontSize * 0.15)
                        .frame(width: maxFrame)
                }
            }
            
        }
        .frame(width: width)
    }
}

struct VideoDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        //GameSettingsView(width: 300, fontSize: 20)
        VideoDetailsView(title: "GHOST / 星街すいせい(official)", channel: "Suisei Channel", duration: "4:42", published: "Apr 13, 2021", description: "「GHOST」作詞：星街すいせい 作曲：佐藤厚仁(Dream Monster) 編曲：佐藤厚仁(Dream Monster) Electric Guitar,Acoustic Guitar：佐藤厚仁(Dream Monster) Electric Bass：森本練 Drums：北村望 映像：mokoppe 歌詞デザイン：紋", width: 300, fontSize: 20)
    }
}

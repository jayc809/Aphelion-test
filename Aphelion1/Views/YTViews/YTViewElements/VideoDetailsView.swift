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
    @State var scrollContent = 1
    @State var scrollSettings = 1
    
    @Binding var refresh: Int
    
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
        return width * 0.45
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
                
                //left arrow
                Button(action: {
                    if currModuleName == "Track Details" {
                        swipeRightDetailsToSettings()
                    }
                    else if currModuleName == "Settings" {
                        swipeRightSettingsToDetails()
                    }
                }, label: {
                    Image(systemName: "arrowtriangle.left.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: moduleNameFontSize * 0.6)
                        .foregroundColor(.white)
                        .frame(width: moduleNameFontSize * 1.2, height: moduleNameFontSize * 1.2)
                        .contentShape(Rectangle())
                })
                
                //module name
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
                
                //right arrow
                Button(action: {
                    
                    if currModuleName == "Settings" {
                        swipeLeftSettingsToDetails()
                    }
                    else if currModuleName == "Track Details" {
                        swipeLeftDetailsToSettings()
                    }
                    
                }, label: {
                    Image(systemName: "arrowtriangle.right.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: moduleNameFontSize * 0.6)
                        .foregroundColor(.white)
                        .frame(width: moduleNameFontSize * 1.2, height: moduleNameFontSize * 1.2)
                        .contentShape(Rectangle())
                })
            }
            .padding(.top, 35)
            .padding(.bottom, 40)
            
            //modules
            GeometryReader { geometry in
                ZStack {
                    
                    VideoContentView(title: title, channel: channel, duration: duration, published: published, description: description, width: width, fontSize: fontSize, scroll: $scrollContent)
                        .onAppear {
                            detailsX = centerTab
                        }
                        .position(x: detailsX, y: geometry.size.height * 0.5)
                
                    GameSettingsView(width: width, fontSize: fontSize, scroll: $scrollSettings)
                        .onAppear {
                            settingsX = leftTab
                        }
                        .position(x: settingsX, y: geometry.size.height * 0.5)
                    
                }
            }
        }
        .frame(width: width, height:  Constants.screenHeight)
        .clipped()
        .onTapGesture {}
        .gesture(swipe)
        .onChange(of: refresh, perform: { value in
            currModuleName = "Track Details"
            detailsX = centerTab
            detailsModuleX = centerModule
            settingsX = rightTab
            settingsModuleX = rightModule
        })
    }
    
    var swipe: some Gesture {
        
        DragGesture(minimumDistance: 0)
            .onEnded({ swipe in
            
                if swipe.translation.width < -width * 0.3 && abs(swipe.translation.height) < 100 {
                    //left
                    if currModuleName == "Settings" {
                        swipeLeftSettingsToDetails()
                    }
                    else if currModuleName == "Track Details" {
                        swipeLeftDetailsToSettings()
                    }
                }
                else if swipe.translation.width > width * 0.3 && abs(swipe.translation.height) < 100 {
                    //right
                    if currModuleName == "Track Details" {
                        swipeRightDetailsToSettings()
                    }
                    else if currModuleName == "Settings" {
                        swipeRightSettingsToDetails()
                    }
                }
            })
    }
    
    func swipeRightDetailsToSettings() {
        scrollSettings += 1
        currModuleName = "Settings"
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
    
    func swipeRightSettingsToDetails() {
        scrollContent += 1
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
    
    func swipeLeftDetailsToSettings() {
        scrollSettings += 1
        currModuleName = "Settings"
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
        detailsX = rightTab
        detailsModuleX = rightModule
    }
    
    func swipeLeftSettingsToDetails() {
        scrollContent += 1
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
        settingsX = rightTab
        settingsModuleX = rightModule
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
    @Binding var scroll: Int
    
    var body: some View {
        
        ScrollViewReader { proxy in
        
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 8) {
                    VStack {
                        Text(title)
                            .font(Font.system(size: fontSize * 1.25))
                            .multilineTextAlignment(.center)
                    }
                    .frame(width: width)
                    .padding(.bottom, 7)
                    .id(1)
                    Text("Artist - \(channel)")
                        .font(Font.system(size: fontSize))
                    Text("Duration - \(duration)")
                        .font(Font.system(size: fontSize))
                    Text("Published - \(published)")
                        .font(Font.system(size: fontSize))
                    Text("Description - ")
                        .font(Font.system(size: fontSize))
                    Text(description)
                        .font(Font.system(size: fontSize))
                        .padding(.bottom, 40)
                }
            }
            .frame(width: width)
            .onChange(of: scroll) { value in
                proxy.scrollTo(1, anchor: .top)
            }
        }
    }
    
}

struct GameSettingsView: View {
    
    var width: CGFloat
    var fontSize: CGFloat
    @Binding var scroll: Int
    
    var body: some View {
        
        let maxFrame = width * 0.4
        let leadingPadding:CGFloat = 0 //fontSize * 0.45
        
        ScrollViewReader { proxy in
            
            ScrollView(showsIndicators: false) {
                
                VStack(spacing: 8) {
                    
                    Group {
                        Text("Gameplay")
                            .font(Font.system(size: fontSize * 1.25))
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 7)
                            .id(1)
                        HStack {
                            Text("Difficulty")
                                .font(Font.system(size: fontSize))
                                .padding(.leading, leadingPadding)
                                .frame(width: maxFrame, alignment: .leading)
                            Spacer()
                            DifficultyButton(fontSize: fontSize)
                                .frame(width: maxFrame)
                        }
                        HStack {
                            Text("Note Speed")
                                .font(Font.system(size: fontSize))
                                .padding(.leading, leadingPadding)
                                .frame(width: maxFrame, alignment: .leading)
                            Spacer()
                            TileSpeedStepper(width: fontSize * 5, height: fontSize + 2, spacing: fontSize * 0.6)
                                .padding(.vertical, -1)
                                .frame(width: maxFrame)
                        }
                        HStack {
                            Text("Slide Notes")
                                .font(Font.system(size: fontSize))
                                .padding(.leading, leadingPadding)
                                .frame(width: maxFrame, alignment: .leading)
                            Spacer()
                            SlideNoteButton(fontSize: fontSize)
                                .frame(width: maxFrame)
                        }
                        HStack {
                            Text("Divine Boost")
                                .font(Font.system(size: fontSize))
                                .padding(.leading, leadingPadding)
                                .frame(width: maxFrame, alignment: .leading)
                            Spacer()
                            DivineBoostButton(fontSize: fontSize)
                                .frame(width: maxFrame)
                        }
                    }
                    Group {
                        Text("Visuals")
                            .font(Font.system(size: fontSize * 1.25))
                            .multilineTextAlignment(.center)
                            .padding(.top, 15)
                            .padding(.bottom, 7)
                        
                        HStack {
                            Text("Note Theme")
                                .font(Font.system(size: fontSize))
                                .padding(.leading, leadingPadding)
                                .frame(width: maxFrame, alignment: .leading)
                            Spacer()
                            TileThemeButton(height: fontSize + 5)
                                .padding(.vertical, -2.5)
                                .frame(width: maxFrame)
                                .offset(y: 1.5)
                        }
                            
                        HStack {
                            Text("Animation Quality")
                                .font(Font.system(size: fontSize))
                                .padding(.leading, leadingPadding)
                                .frame(width: maxFrame, alignment: .leading)
                            Spacer()
                            AnimationQualityButton(fontSize: fontSize)
                                .frame(width: maxFrame)
                        }
                        
                        
                        HStack {
                            Text("Animation Offset")
                                .font(Font.system(size: fontSize))
                                .padding(.leading, leadingPadding)
                                .frame(width: maxFrame, alignment: .leading)
                            Spacer()
                            AnimationOffsetStepper(width: fontSize * 5, height: fontSize + 2, spacing: fontSize * 0.15)
                                .frame(width: maxFrame)
                        }
                        
                        HStack {
                            Text("Background")
                                .font(Font.system(size: fontSize))
                                .padding(.leading, leadingPadding)
                                .frame(width: maxFrame, alignment: .leading)
                            Spacer()
                            GameBackgroundButton(fontSize: fontSize)
                                .frame(width: maxFrame)
                        }
        
                        HStack {
                            Text("Brightness & Saturation")
                                .font(Font.system(size: fontSize))
                                .padding(.leading, leadingPadding)
                                .frame(width: maxFrame, alignment: .leading)
                            Spacer()
                            BrightnessAndSaturationButton(arrowWidth: width * 0.05)
                                .frame(width: maxFrame)
                        }
                    }
                    
                    Group {
                        Text("Sounds")
                            .font(Font.system(size: fontSize * 1.25))
                            .multilineTextAlignment(.center)
                            .padding(.top, 15)
                            .padding(.bottom, 7)
                        HStack {
                            Text("Sound Effects")
                                .font(Font.system(size: fontSize))
                                .padding(.leading, leadingPadding)
                                .frame(width: maxFrame, alignment: .leading)
                            Spacer()
                            SoundEffectsButton(fontSize: fontSize)
                                .frame(width: maxFrame)
                        }
                        HStack {
                            Text("Audio Offset")
                                .font(Font.system(size: fontSize))
                                .padding(.leading, leadingPadding)
                                .frame(width: maxFrame, alignment: .leading)
                            Spacer()
                            AudioOffsetStepper(width: fontSize * 5, height: fontSize + 2, spacing: fontSize * 0.15)
                                .frame(width: maxFrame)
                        }
                        .padding(.bottom, 40)
                    }
                }
                .frame(width: width)
            
            }
            .onChange(of: scroll) { value in
                proxy.scrollTo(1, anchor: .top)
            }
            
        }
        
    }
}
//
//struct VideoDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameSettingsView(width: 300, fontSize: 20)
////        VideoDetailsView(title: "GHOST / 星街すいせい(official)", channel: "Suisei Channel", duration: "4:42", published: "Apr 13, 2021", description: "「GHOST」作詞：星街すいせい 作曲：佐藤厚仁(Dream Monster) 編曲：佐藤厚仁(Dream Monster) Electric Guitar,Acoustic Guitar：佐藤厚仁(Dream Monster) Electric Bass：森本練 Drums：北村望 映像：mokoppe 歌詞デザイン：紋", width: 300, fontSize: 20)
//    }
//}

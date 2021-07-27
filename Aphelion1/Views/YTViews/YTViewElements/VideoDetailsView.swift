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
    @State var showAnnotations = 1 //nothing - 1, animation offset - 2, background - 3, brightness saturation - 4, audio offset - 5
    
    @Binding var refresh: Int
    @Binding var _brightness: Double
    @Binding var _saturation: Double
    
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
        ZStack {
            
            //main content
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
                    
                        GameSettingsView(width: width, fontSize: fontSize, scroll: $scrollSettings, showAnnotations: $showAnnotations, _brightness: $_brightness, _saturation: $_saturation)
                            .onAppear {
                                settingsX = leftTab
                            }
                            .position(x: settingsX, y: geometry.size.height * 0.5)
                        
                    }
                }
            }
            .frame(width: width, height:  Constants.screenHeight)
            .onTapGesture {}
            .gesture(swipe)
            .onChange(of: refresh, perform: { value in
                currModuleName = "Track Details"
                detailsX = centerTab
                detailsModuleX = centerModule
                settingsX = rightTab
                settingsModuleX = rightModule
                showAnnotations = 1
            })
            
            //annotations
            SettingsAnnotations(showAnnotations: $showAnnotations, width: width * 0.92, fontSize: fontSize)
                .position(x: width * 0.5, y: Constants.screenHeight * 0.6)
        }
        .frame(width: width, height:  Constants.screenHeight)
        .clipped()
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
        showAnnotations = 1
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
        showAnnotations = 1
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
        showAnnotations = 1
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
        showAnnotations = 1
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
                    let _duration = getYTDuration(durationString: duration)
                    Text("Duration - \(_duration)")
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


struct VideoDetailsPreview: View {
    @State var refresh = 0
    @State var _brightness = 1.2
    @State var _saturation = 1.2
    var body: some View {
        VideoDetailsView(title: "GHOST / 星街すいせい(official)", channel: "Suisei Channel", duration: "4:42", published: "Apr 13, 2021", description: "「GHOST」作詞：星街すいせい 作曲：佐藤厚仁(Dream Monster) 編曲：佐藤厚仁(Dream Monster) Electric Guitar,Acoustic Guitar：佐藤厚仁(Dream Monster) Electric Bass：森本練 Drums：北村望 映像：mokoppe 歌詞デザイン：紋", width: 300, fontSize: 20, refresh: $refresh, _brightness: $_brightness, _saturation: $_saturation)
    }
}


struct VideoDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        VideoDetailsPreview()
    }
}

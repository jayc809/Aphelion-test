//
//  GameSettingsView.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/26.
//

import SwiftUI

struct GameSettingsView: View {
    
    var width: CGFloat
    var fontSize: CGFloat
    @Binding var scroll: Int
    @Binding var showAnnotations: Int //nothing - 1, animation offset - 2, background - 3, brightness saturation - 4, audio offset - 5
    @Binding var _brightness: Double
    @Binding var _saturation: Double
    
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
                        
                        
                        HStack(spacing: 0) {
                            Text("Animation Offset")
                                .font(Font.system(size: fontSize))
                                .padding(.leading, leadingPadding)
                                .frame(width: maxFrame, alignment: .leading)
                            Button(action: {
                                showAnnotations = 2
                            }, label: {
                                Image(systemName: "questionmark.circle")
                                    .resizable()
                                    .frame(width: fontSize, height: fontSize)
                                    .foregroundColor(.white)
                            })
                            Spacer()
                            AnimationOffsetStepper(width: fontSize * 5, height: fontSize + 2, spacing: fontSize * 0.15)
                                .frame(width: maxFrame)
                        }
                        
                        HStack(spacing: 0) {
                            Text("Background")
                                .font(Font.system(size: fontSize))
                                .padding(.leading, leadingPadding)
                                .frame(width: maxFrame, alignment: .leading)
                            Button(action: {
                                showAnnotations = 3
                            }, label: {
                                Image(systemName: "questionmark.circle")
                                    .resizable()
                                    .frame(width: fontSize, height: fontSize)
                                    .foregroundColor(.white)
                            })
                            Spacer()
                            GameBackgroundButton(fontSize: fontSize)
                                .frame(width: maxFrame)
                        }
        
                        HStack(spacing: 0) {
                            Text("Brightness & Saturation")
                                .font(Font.system(size: fontSize))
                                .padding(.leading, leadingPadding)
                                .frame(width: maxFrame, alignment: .leading)
                            Button(action: {
                                showAnnotations = 4
                            }, label: {
                                Image(systemName: "questionmark.circle")
                                    .resizable()
                                    .frame(width: fontSize, height: fontSize)
                                    .foregroundColor(.white)
                            })
                            Spacer()
                            BrightnessAndSaturationButton(_brightness: $_brightness, _saturation: $_saturation, arrowWidth: width * 0.05)
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
                        HStack(spacing: 0) {
                            Text("Audio Offset")
                                .font(Font.system(size: fontSize))
                                .padding(.leading, leadingPadding)
                                .frame(width: maxFrame, alignment: .leading)
                            Button(action: {
                                showAnnotations = 5
                            }, label: {
                                Image(systemName: "questionmark.circle")
                                    .resizable()
                                    .frame(width: fontSize, height: fontSize)
                                    .foregroundColor(.white)
                            })
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

struct GameSettingsPreview: View {
    @State var scroll = 0
    @State var showAnnotations = 1
    @State var _brightness = 1.2
    @State var _saturation = 1.2
    var body: some View {
        GameSettingsView(width: 300, fontSize: 20, scroll: $scroll, showAnnotations: $showAnnotations, _brightness: $_brightness, _saturation: $_saturation)
    }
}

struct GameSettingsView_Previews: PreviewProvider {
    static var previews: some View {
       GameSettingsPreview()
    }
}

//
//  VisualSettings.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/18.
//

import SwiftUI

struct TileThemeButton: View {
    
    @State var _tileType = tileType
    var height: CGFloat
    
    var body: some View {
        Button(action: {
            if tileType == "Regular" {
                tileType = "Beat"
                _tileType = "Beat"
            }
            else {
                tileType = "Regular"
                _tileType = "Regular"
            }
        }, label: {
            Image("Tap\(_tileType)Pause")
                .resizable()
                .scaledToFit()
                .frame(height: height)
        })
    }
}

struct AnimationOffsetStepper: View {
    
    @State var _framesAdjusted = framesAdjusted
    var width: CGFloat
    var height: CGFloat
    var spacing: CGFloat
    
    var body: some View {
        ZStack {
            Image("PauseStepper")
                .resizable()
                .frame(width: width, height: height)
            
            HStack(spacing: spacing) {
                //minus
                Button(action: {
                    if framesAdjusted > -10 {
                        framesAdjusted -= 1
                        _framesAdjusted -= 1
                    }
                }, label: {
                    Image(systemName: "minus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: height - 11)
                        .foregroundColor(.white)
                        .frame(width: height, height: height)
                        .contentShape(Rectangle())
                })
                //number
                Text(String(_framesAdjusted))
                    .font(.custom("Avenir Next Regular", size: height - 5))
                    .foregroundColor(.white)
                    .frame(width: width * 0.4)
                //plus
                Button(action: {
                    if framesAdjusted < 30 {
                        framesAdjusted += 1
                        _framesAdjusted += 1
                    }
                }, label: {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(height: height - 11)
                        .foregroundColor(.white)
                        .frame(width: height, height: height)
                        .contentShape(Rectangle())
                })
            }
        }
    }
}

struct AnimationQualityButton: View {
    
    @State var _animationQuality = animationQuality
    var fontSize: CGFloat
    
    var body: some View {
        Button(action: {
            if animationQuality < 3 {
                animationQuality += 1
                _animationQuality += 1
            }
            else {
                animationQuality = 1
                _animationQuality = 1
            }
        }, label: {
            Text(_animationQuality == 1 ? "Stable" : _animationQuality == 2 ?  "Smooth" : "Best")
                .font(Font.system(size: fontSize))
                .foregroundColor(.white)
                .bold()
        })
    }
}

struct GameBackgroundButton: View {
    
    @State var _useBackground = useBackground
    var fontSize: CGFloat
    
    var body: some View {
        Button(action: {
            if useBackground < 3 {
                useBackground += 1
                _useBackground += 1
            }
            else {
                useBackground = 1
                _useBackground = 1
            }
        }, label: {
            Text(_useBackground == 1 ? "Video" : _useBackground == 2 ?  "Custom Image" : "Video Thumbnail")
                .font(Font.system(size: fontSize))
                .foregroundColor(.white)
                .bold()
        })
    }
    
}

struct BrightnessAndSaturationButton: View {
    
    @State var _videoBrightness = videoBrightness
    @State var _videoSaturation = videoSaturation
    var arrowWidth: CGFloat
    
    var body: some View {
        VStack(spacing: arrowWidth * 0.5) {
            
            //brightness up
            Button(action: {
                _videoBrightness += 0.03
                videoBrightness += 0.03
                
            }, label: {
                Image(systemName: "arrowtriangle.up.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: arrowWidth)
                    .foregroundColor(.white)
            })
            HStack(spacing: arrowWidth * 0.5) {
                //saturation down
                Button(action: {
                    _videoSaturation -= 0.18
                    videoSaturation -= 0.18
                }, label: {
                    Image(systemName: "arrowtriangle.left.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: arrowWidth)
                        .foregroundColor(.white)
                })
                
                Rectangle()
                    .foregroundColor(Color(red: 158/255, green: 123/255, blue: 251/255))
                    .hueRotation(determineHue(combo: 0))
                    .frame(width: arrowWidth * 2.5, height: arrowWidth * 2.5)
                    .brightness(_videoBrightness)
                    .saturation(_videoSaturation)
                
                //saturation up
                Button(action: {
                    _videoSaturation += 0.18
                    videoSaturation += 0.18
                }, label: {
                    Image(systemName: "arrowtriangle.right.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: arrowWidth)
                        .foregroundColor(.white)
                })
            }
            
            //brightness down
            Button(action: {
                _videoBrightness -= 0.03
                videoBrightness -= 0.03
            }, label: {
                Image(systemName: "arrowtriangle.down.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: arrowWidth)
                    .foregroundColor(.white)
            })
            
        }
    }
}

struct ThemeButton_Previews: PreviewProvider {
    static var previews: some View {
        AnimationOffsetStepper(width: 80, height: 20, spacing: 12)
    }
}


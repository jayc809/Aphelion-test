//
//  Constants.swift
//  Aphelion
//
//  Created by Jay on 2021/6/2.
//

import Foundation
import SwiftUI

//YTView
var difficulty = 3 // 1 - easy, 2 - medium, 3 - hard, 4 - specialist
var tileSpeed = 1.1
var tileSpeedOriginal = 1.1
var animationQuality = 3 // 1 - stable, 2 - smooth, 3 - best
var useBackground = 1 // 1 - video, 2 - user image, 3 - thumbnail
var detectPosition = Constants.screenHeight * 0.55
var slideNoteOff = false
var divineBoostOff = false

//Gameplay settings
var framesAdjusted = 9
var tileType = "Beat"
var videoSaturation = 1.2
var videoBrightness = -0.1
var soundEffectsOff = false
var audioOffset = 0

//color change
let stage1 = 50
let stage2 = 100
let stage3 = 150
let stage4 = 200

//tolerance
let toleranceDiv = CGFloat(35)
let toleranceGood = CGFloat(120)

class Constants {
    
    //screen
    static let screenWidth = UIScreen.main.bounds.width
    static let halfScreenWidth = UIScreen.main.bounds.width / 2
    static let screenHeight = UIScreen.main.bounds.height
    static let halfScreenHeight = UIScreen.main.bounds.height / 2
    static let tapLinePosition = UIScreen.main.bounds.height * 5 / 6
    
    //tile
    static let tileSize: CGFloat = 155
    static let tileAnimationSize: CGFloat = 155 * 700 / 550 //change with tile size
    static let slideLineSize: CGFloat = 155 * 0.8
    static let slideAnimationSize: CGFloat = 155 * 1200 / 550
    
    static let tileXMin = 0 - ((UIScreen.main.bounds.width / 2) - 100) //change with tile size
    static let tileXMax = (UIScreen.main.bounds.width / 2) - 100 //change with tile size
    static let tileYMin = 0 - (UIScreen.main.bounds.height / 7)
    static let tileMoveScale = (UIScreen.main.bounds.height + 130) / ((UIScreen.main.bounds.height * 5 / 6) + 80)
    
    //color
    static let purple = Color(red: 159/255, green: 123/255, blue: 251/255)
    static let hue1 = Angle(degrees: -20)
    static let hue2 = Angle(degrees: -14)
    static let hue3 = Angle(degrees: -8)
    static let hue4 = Angle(degrees: 2)
    static let hue5 = Angle(degrees: 10)
    
    //youtube
    static let apiUrl = "https://www.googleapis.com/youtube/v3"
    static let apiKey = "AIzaSyBld05sx_Mo76i7WdjhuAPdfv2nUVmrx50"
    
}

func determineHue(combo: Int) -> Angle {
    
    var hue = Constants.hue1
    
    if combo < stage1  {
        hue = Constants.hue1
    }
    else if combo < stage2  {
        hue = Constants.hue2
    }
    else if combo < stage3  {
        hue = Constants.hue3
    }
    else if combo < stage4  {
        hue = Constants.hue4
    }
    else {
        hue = Constants.hue5
    }
    
    return hue
}

func getYTDuration(durationString: String) -> String {

  let formattedDuration = durationString.replacingOccurrences(of: "PT", with: "").replacingOccurrences(of: "H", with:":").replacingOccurrences(of: "M", with: ":").replacingOccurrences(of: "S", with: "")

  let components = formattedDuration.components(separatedBy: ":")
  var duration = ""
  for component in components {
      duration = duration.count > 0 ? duration + ":" : duration
      if component.count < 2 {
          duration += "0" + component
          continue
      }
      duration += component
  }

  return duration

}

extension View {
    func glow(color: Color = .white, radius: CGFloat, scale: CGFloat) -> some View {
        self
            .shadow(color: color, radius: radius)
            .shadow(color: color, radius: radius * scale)
            .shadow(color: color, radius: radius * scale * 0.5)
    }
}

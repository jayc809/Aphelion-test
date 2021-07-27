//
//  TestView.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/19.
//

import youtube_ios_player_helper
import SwiftUI

let ghostId = "IKKar5SS29E"
let racingId = "4X-eZH87BTw"


class YTManager: ObservableObject {
    
    var player = YTPlayerView()
    
    init(videoID: String) {
        let playerVars = ["cc_load_policy": 2, "controls": 0, "disablekb": 1, "iv_load_policy": 3, "modestbranding": 1, "playsinline": 1, "rel": 0,  "showinfo": 0]
        player.load(withVideoId: videoID, playerVars: playerVars)
    }
    
    init(videoID: String, preview: Bool) {
        let playerVars = ["controls": 0, "disablekb": 1, "end": 90, "iv_load_policy": 3, "modestbranding": 1, "playsinline": 1, "rel": 0,  "showinfo": 0, "start": 60]
        player.load(withVideoId: videoID, playerVars: playerVars)

    }
    
    func play() {
        player.playVideo()
    }
    
    func pause() {
        player.pauseVideo()
    }
    
}

struct YTRepresented : UIViewRepresentable {
    
    var player: YTPlayerView
    
    func makeUIView(context: Context) -> YTPlayerView {
        return player
    }
    
    func updateUIView(_ uiView: YTPlayerView, context: Context) {
        
    }
    
}

struct TestPlayYTVideo: View {
    
    @State var timer = Timer.publish(every: 0.1, on: .current, in: .common).autoconnect()
    @State var rectPositionTop = CGPoint(x: Constants.screenWidth * 0.5, y: Constants.screenHeight * 0.25)
    @State var rectPositionBottom = CGPoint(x: Constants.screenWidth * 0.5, y: Constants.screenHeight * 0.75)
    @State var finishedRevealing = false
    
    var body: some View {
        ZStack {
            let ytManager = YTManager(videoID: ghostId)//"MPS1Ta1q7F4")
            YTRepresented(player: ytManager.player)
                .onReceive(timer) { _ in
                    ytManager.player.videoLoadedFraction { fraction, error in
                        if fraction >= 0.05 {
                            withAnimation(.linear(duration: 1.2).delay(2)) {
                                rectPositionTop.y -= Constants.screenWidth * 0.5
                                rectPositionBottom.y += Constants.screenWidth * 0.5
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.3) {
                                    finishedRevealing = true
                            }
                            timer.upstream.connect().cancel()
                        }
                        else if fraction >= 0 {
                            ytManager.play()
                        }
                    }
                }
                .frame(width: 480, height: 270)
                .allowsHitTesting(false)
            
            if finishedRevealing == false {
                Rectangle()
                    .frame(width: Constants.screenWidth * 1.3, height: Constants.screenHeight * 0.5)
                    .foregroundColor(.black)
                    .position(rectPositionTop)
                Rectangle()
                    .frame(width: Constants.screenWidth * 1.3, height: Constants.screenHeight * 0.5)
                    .foregroundColor(.black)
                    .position(rectPositionBottom)
            }
        }
    }
}

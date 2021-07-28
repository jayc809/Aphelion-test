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
let getchaId = "EjlMPu5sEgw"
let waltzId = "pyDCubgU57g"


class YTManager: ObservableObject {
    
    var player = YTPlayerView()
    
    init(videoID: String) {
        player.frame = CGRect(x: 0, y: 0, width: 4096, height: 2160)
        player.load(withVideoId: videoID, playerVars: ["cc_load_policy": 2,
                                                       "controls": 0,
                                                       "disablekb": 1,
                                                       "enablejsapi": 1,
                                                       "iv_load_policy": 3,
                                                       "modestbranding": 1,
                                                       "origin": "https://www.example.com",
                                                       "playsinline": 1,
                                                       "rel": 0,
                                                       "showinfo": 0])
    }
    
    init(videoID: String, preview: Bool) {
        player.load(withVideoId: videoID, playerVars: ["controls": 0,
                                                       "disablekb": 1,
                                                       "end": 90,
                                                       "iv_load_policy": 3,
                                                       "modestbranding": 1,
                                                       "playsinline": 1,
                                                       "rel": 0,
                                                       "showinfo": 0,
                                                       "start": 60])

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
    @State var finishedRevealing = false
    @State var opacity = 1.0
    
    var body: some View {
        ZStack {
            ZStack {
                let ytManager = YTManager(videoID: ghostId)
                YTRepresented(player: ytManager.player)
                    .onReceive(timer) { _ in
                        ytManager.player.videoLoadedFraction { fraction, error in
                            if fraction >= 0.05 {
                                withAnimation(.easeIn(duration: 1).delay(2.3)) {
                                    opacity = 0
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
                    .allowsHitTesting(false)
                
                if finishedRevealing == false {
                    Rectangle()
                        .frame(width: Constants.screenWidth, height: Constants.screenHeight)
                        .foregroundColor(.black)
                        .opacity(opacity)
                }
            }
        }
    }
}


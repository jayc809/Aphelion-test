//
//  TestView.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/19.
//

import youtube_ios_player_helper
import SwiftUI

let ghostId = "IKKar5SS29E"

class YTManager: ObservableObject {
    
    var player = YTPlayerView()
    
    init(videoID: String) {
        let playerVars = ["autoplay": 1, "controls": 0, "disablekb": 1, "iv_load_policy": 3, "modestbranding": 1, "playsinline": 1, "rel": 0,  "showinfo": 0]
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

struct TestView: View {
    
    @State var timer = Timer.publish(every: 2, on: .current, in: .common).autoconnect()
    @StateObject var ytManager = YTManager(videoID: ghostId)
    
    var body: some View {
        ZStack {
            YTRepresented(player: ytManager.player)
                .onReceive(timer) { _ in
                    ytManager.play()
                    timer.upstream.connect().cancel()
                }
                .allowsHitTesting(false)
        }
    }
}

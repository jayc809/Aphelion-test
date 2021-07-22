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
        player.load(withVideoId: videoID)
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
    
    @State var timer = Timer.publish(every: 3, on: .current, in: .common).autoconnect()
    @StateObject var ytManager = YTManager(videoID: ghostId)
    @State var startPlaying = false
    
    var body: some View {
        YTRepresented(player: ytManager.player)
            .onReceive(timer, perform: { _ in
                if startPlaying == false {
                    ytManager.play()
                    startPlaying = true
                }
            })
    }
}

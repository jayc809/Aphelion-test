//
//  VideoTest.swift
//  Aphelion
//
//  Created by Jay on 2021/6/18.
//

import SwiftUI
import AVKit

class PlayerManager: ObservableObject {
    
    var player = AVPlayer()
    @Published private var playing = false
    
    init(file: String) {
        player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forAuxiliaryExecutable: file)!))
    }
    
    func play() {
        player.play()
        playing = true
    }
    
    func playPause() {
        if playing {
            player.pause()
        }
        else {
            player.play()
        }
        playing.toggle()
    }
}

struct AVPlayerControllerRepresented: UIViewControllerRepresentable {
    
    var player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
}

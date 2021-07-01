//
//  Gif.swift
//  Aphelion
//
//  Created by Jay on 2021/6/11.
//

import SwiftUI

struct PlayGif: View {
        
    var fileName: String
    var maxNum: Int
    var frameY: CGFloat
    
    @State var num = 0
    @State var timer = Timer.publish(every: 0.015, on: .main, in: .common).autoconnect()
    @State var show = true
    
    var body: some View {
        if show{
        Image("\(fileName)_\(String(format: "%05d", num))")
            .resizable()
            .onReceive(timer, perform: { _ in
                if num > (maxNum - 2) {
                    show = false
                    timer.upstream.connect().cancel()
                }
                num += 1
            })
            .aspectRatio(contentMode: .fit)
            .frame(width: frameY)
        }
    }
}

struct PlayGifLoop: View {
        
    var fileName: String
    var loopStart: Int
    var loopEnd: Int
    var frameY: CGFloat
    
    @State var num = 0
    @State var timer = Timer.publish(every: 0.015, on: .main, in: .common).autoconnect()
    @State var show = true
    
    var body: some View {
        if show{
        Image("\(fileName)_\(String(format: "%05d", num))")
            .resizable()
            .onReceive(timer, perform: { _ in
                if num == loopEnd {
                    num = loopStart
                }
                else {
                    num += 1
                }
            })
            .aspectRatio(contentMode: .fit)
            .frame(width: frameY)
        }
    }
}

struct Gif_Previews: PreviewProvider {
    static var previews: some View {
        PlayGifLoop(fileName: "HoldBeatGood", loopStart: 26, loopEnd: 48, frameY: 200)
    }
}

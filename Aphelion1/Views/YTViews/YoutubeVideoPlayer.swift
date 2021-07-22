//
//  WebView.swift
//  swiftui-youtube-onedaybuild
//
//  Created by Micah Beech on 2020-11-04.
//

import SwiftUI
import WebKit

struct YoutubeVideoPlayer: UIViewRepresentable {
    
    var videoID: String
    
    func makeUIView(context: Context) -> WKWebView  {
        
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        
        let view = WKWebView()
        
        // Create the embed URL
        let embedUrlString = Constants.embedUrl + videoID
        
        // Load it into the webview
        let url = URL(string: embedUrlString)
        let request = URLRequest(url: url!)
        view.load(request)
        
        return view
    }
      
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        YoutubeVideoPlayer(videoID: "IKKar5SS29E")
    }
}

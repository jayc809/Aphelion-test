//
//  VideoPreview.swift
//  YoutubeApp
//
//  Created by Jay on 2021/7/7.
//

import Foundation
import Alamofire

class VideoPreview: ObservableObject {
    
    @Published var thumbnailData = Data()
    @Published var title: String
    @Published var date: String
    
    var video: Video
    
    init(video: Video) {
        
        self.video = video
        self.title = video.title
        
        // Set the date
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        self.date = df.string(from: video.published)
        
        // Set the thumbnail
        guard video.thumbnail != "" else { return }
        
        // Check cache before downloading data
        if let cachedData = CacheManager.getVideoCache(video.thumbnail) {
            
            // Set the thumbnail imageview
            thumbnailData = cachedData
            return
        }
        
        // Download the thumbnail data
        guard let url = URL(string: video.thumbnail) else { return }
        
        AF.request(url).validate().responseData { response in
            
            if let data = response.data {
                // Save the data in the cache
                CacheManager.setVideoCache(video.thumbnail, data)
                
                // Set the image
                DispatchQueue.main.async {
                    self.thumbnailData = data
                }
            }
        }
    }
    
}

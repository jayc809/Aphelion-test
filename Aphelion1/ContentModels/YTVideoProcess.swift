//
//  YTVideoProcess.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/9.
//

import Foundation
import Alamofire

class YTVideoProcess: ObservableObject {
    
    @Published var thumbnailData = Data()
    var ytVideoInfo: YTVideoInfo
    
    init(ytVideoInfo: YTVideoInfo) {
        
        self.ytVideoInfo = ytVideoInfo
        
        guard ytVideoInfo.thumbnailId != ""
        else {
            return
        }
        //if exists in cache
        if let cachedThumbnailData = CacheManager.getYTVideoCache(ytVideoInfo.thumbnailId) {
            thumbnailData = cachedThumbnailData
        }
        //else download to cache
        guard let url = URL(string: ytVideoInfo.thumbnailId)
        else {
            return
        }
        AF.request(url)
            .validate()
            .responseData { response in
                if let data = response.data {
                    CacheManager.setYTVideoCache(ytVideoInfo.thumbnailId, data)
                    DispatchQueue.main.async {
                        self.thumbnailData = data
                    }
                }
            }
        
    }
    
}

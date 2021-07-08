//
//  CacheManager.swift
//  YoutubeApp
//
//  Created by Jay on 2021/7/8.
//

import Foundation

class CacheManager {

    static var ytVideoCache = [String:Data]()
    
    static func setYTVideoCache(_ url:String, _ data:Data?) {
        
        // Store the image data and use the url as the key
        ytVideoCache[url] = data
        
    }
    
    static func getYTVideoCache(_ url:String) -> Data? {
        
        // Try to get the data for the specified url
        return ytVideoCache[url]
    }
    
    
}

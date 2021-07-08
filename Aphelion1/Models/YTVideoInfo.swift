//
//  YTVideoInfo.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/9.
//

import Foundation

struct YTVideoInfo: Decodable {
    
    var videoId = ""
    var videoName = ""
    var thumbnailId = ""
    var channelName = ""
    
    enum CodingKeys: String, CodingKey {
        
        case snippet
        case thumbnails
        case high
        case id
        
        case videoId
        case videoName = "title"
        case thumbnailId = "url"
        case channelName = "channelTitle"
        
    }
    
    //for testing
    init() {
        self.videoId = "IKKar5SS29E"
        self.videoName = "GHOST / 星街すいせい(official)"
        self.thumbnailId = "https://i.ytimg.com/vi/IKKar5SS29E/hqdefault.jpg"
        self.channelName = "Suisei Channel"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        //video url
        let idContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .id)
        self.videoId = try idContainer.decode(String.self, forKey: .videoId)
        
        //video name
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        self.videoName = try snippetContainer.decode(String.self, forKey: .videoName)
        
        //thumbnail url
        let thumbnailContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails)
        let highResContainer = try thumbnailContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high)
        self.thumbnailId = try highResContainer.decode(String.self, forKey: .thumbnailId)
        
        //channel name
        self.channelName = try snippetContainer.decode(String.self, forKey: .channelName)
        
    }
    
}
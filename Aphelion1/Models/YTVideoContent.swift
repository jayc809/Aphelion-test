//
//  YTResponseContent.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/15.
//

import SwiftUI

struct YTRepsonseContent: Decodable {
    
    var items: [YTVideoContent]?
    
    enum CodingKeys: String, CodingKey {
        
        case items
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.items = try container.decode([YTVideoContent].self, forKey: .items)
    }
    
}

struct YTVideoContent: Decodable {
    
    var published = ""
    var description = ""
    
    
    enum CodingKeys: String, CodingKey {
        
        case snippet
        case publishedAt
        case description
        
    }
    
    init() {
        self.published = ""
        self.description = ""
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        //published
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        self.published = try snippetContainer.decode(String.self, forKey: .publishedAt)
        
        //description
        self.description = try snippetContainer.decode(String.self, forKey: .description)
    }
    
}

struct YTRepsonseDuration: Decodable {
    
    var items: [YTVideoDuration]?
    
    enum CodingKeys: String, CodingKey {
        
        case items
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.items = try container.decode([YTVideoDuration].self, forKey: .items)
    }
    
}

struct YTVideoDuration: Decodable {
    
    var duration = ""
    
    enum CodingKeys: String, CodingKey {
        
        case contentDetails
        case duration
        
    }
    
    init() {
        self.duration = ""
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        //published
        let contentDetailsContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .contentDetails)
        self.duration = try contentDetailsContainer.decode(String.self, forKey: .duration)
        
    }
    
}

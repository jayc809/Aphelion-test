//
//  YTResponseContent.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/15.
//

import SwiftUI

struct YTContent: Decodable {
    
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
        
        //duration
        let contentDetailsContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .contentDetails)
        self.duration = try contentDetailsContainer.decode(String.self, forKey: .duration)
    }
    
}

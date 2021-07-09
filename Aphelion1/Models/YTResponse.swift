//
//  YTResponse.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/9.
//

import SwiftUI

struct YTResponse: Decodable {
    
    var items: [YTVideoInfo]?
    
    enum CodingKeys: String, CodingKey {
        
        case items
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.items = try container.decode([YTVideoInfo].self, forKey: .items)
    }
    
}

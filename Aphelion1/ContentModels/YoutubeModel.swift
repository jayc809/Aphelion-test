//
//  VideoModel.swift
//  YoutubeApp
//
//  Created by Jay on 2021/7/7.
//

import Foundation
import Alamofire

class VideoModel: ObservableObject {
    
    @Published var videos = [Video]()
    
    init() {
        getVideos()
    }
    
    func getVideos() {
        
        // Create a URL object
        guard let url = URL(string: "\(Constants.apiUrl)/playlistItems") else {
            return
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        AF.request(
            url,
            parameters: ["part": "snippet", "playlistId": Constants.playlistId, "maxResults": 10, "key": Constants.apiKey]
        )
        .validate()
        .responseDecodable(of: Response.self, decoder: decoder) { response in
            
            // Check that the call was successful
            switch response.result {
            case .success:
                break
            case .failure(let error):
                print(error.localizedDescription)
                return
            }
            
            // Update the UI with the videos
            if let items = response.value?.items {
                DispatchQueue.main.async {
                    self.videos = items
                }
            }
        }
    }
}

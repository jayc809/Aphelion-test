//
//  YTContentModel.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/16.
//

import Foundation
import Alamofire

class YTContentModel: ObservableObject {
    
    @Published var ytVideoContent = YTVideoContent()
    @Published var ytVideoDuration = YTVideoDuration()
    
    init() {
    }
    
    func getYTVideoDuration(videoId: String) {
        
        //make url
        guard let url = URL(string: "\(Constants.apiUrl)/videos")
        else {
            return
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        //make request
        AF.request(
            url,
            parameters: [
                "part": "contentDetails",
                "id": videoId,
                "key": Constants.apiKey
            ]
        )
        //.validate()
        .responseDecodable(of: YTRepsonseDuration.self, decoder: decoder) { response in
            
            //check validity
            switch response.result {
            case .success:
                break
            case .failure(let error):
                print(error.localizedDescription)
                return
            }
            
            if let _ytVideoDuration = response.value?.items?[0] {
                DispatchQueue.main.async {
                    self.ytVideoDuration = _ytVideoDuration
                }
            }
            
        }
        
    }
    
    func getYTVideoContent(videoId: String) {
        
        //make url
        guard let url = URL(string: "\(Constants.apiUrl)/videos")
        else {
            return
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        //make request
        AF.request(
            url,
            parameters: [
                "part": "snippet",
                "id": videoId,
                "key": Constants.apiKey
            ]
        )
        //.validate()
        .responseDecodable(of: YTRepsonseContent.self, decoder: decoder) { response in
            
            //check validity
            switch response.result {
            case .success:
                break
            case .failure(let error):
                print(error.localizedDescription)
                return
            }
            
            if let _ytVideoContent = response.value?.items?[0] {
                DispatchQueue.main.async {
                    self.ytVideoContent = _ytVideoContent
                }
            }
            
        }
        
    }
    
}


//
//  YTModel.swift
//  Aphelion1
//
//  Created by Jay on 2021/7/9.
//

import Foundation
import Alamofire

class YTModel: ObservableObject {
    
    @Published var ytVideoInfos = [YTVideoInfo]()
    
    init() {
        getYTVideoInfos()
    }
    
    func getYTVideoInfos() {
        
        //make url
        guard let url = URL(string: "\(Constants.apiUrl)/search")
        else {
            return
        }
        
        let decoder = JSONDecoder()
        
        //make request
        AF.request(
            url,
            parameters: [
                "part": "snippet",
                "maxResults": 15,
                "q": searchWord,
                "type": "video",
                "key": Constants.apiKey
            ]
        )
        .validate()
        .responseDecodable(of: YTResponse.self, decoder: decoder) { response in
            
            //check validity
            switch response.result {
            case .success:
                break
            case .failure(let error):
                print(error.localizedDescription)
                return
            }
            
            //update UI
            if let items = response.value?.items {
                DispatchQueue.main.async {
                    self.ytVideoInfos = items
                }
            }
            
        }
        
    }
    
}

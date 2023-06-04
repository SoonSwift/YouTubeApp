//
//  VideoModel.swift
//  YoutubeaApp
//
//  Created by Marcin Dytko on 19/05/2023.
//

import Foundation
import Alamofire

class VideoModel: ObservableObject {
    
    @Published var videos = [Video]()
    
    init() {
        getVideos()
    }
    
    func getVideos() {
        
        // url obj
        guard let url = URL(string: "\(Constants.apiUrl)/playlistItems") else {return}
        // get decoder
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        // crate url request
        AF.request(
            url,
            parameters: ["part": "snippet", "playlistId": Constants.playlistId, "key": Constants.apiKey]
        )
        // check if the response is good (200)
        .validate()
        
        .responseDecodable(of: Response.self, decoder: decoder) { response in
            
            // Check success
            switch response.result {
            case .success :
                break
            case .failure(let error) :
                print(error.localizedDescription)
                return
            }
            
            // Update videos
            if let items = response.value?.items {
                DispatchQueue.main.async {
                    self.videos = items
                }
            }
        }
    }
}

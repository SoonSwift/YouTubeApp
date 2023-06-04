//
//  VideoPreview.swift
//  YoutubeaApp
//
//  Created by Marcin Dytko on 19/05/2023.
//

import Foundation
import Alamofire

class VideoPreview: ObservableObject {
    
    @Published var thumbnailData = Data()
    @Published var title: String
    @Published var date: String
    
    var video: Video
    
    init(video: Video) {
        
        self.video = video
        self.title = video.title
        
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        self.date = df.string(from: video.published)
        
        // image
        guard video.thumbnail != "" else { return }
        
        // check before downolding
        if let cachedData = CacheManager.getVideoCache(video.thumbnail) {
            // Set data
            thumbnailData = cachedData
            return
        }
        
        guard let url = URL(string: video.thumbnail) else { return }
        
        AF.request(url).validate().responseData { response in
            
            if let data = response.data {
                //save data
                CacheManager.setVideoCache(video.thumbnail, data)
                
                // set image
                DispatchQueue.main.async {
                    self.thumbnailData = data
                }
            }
        }
        
    }
    
}

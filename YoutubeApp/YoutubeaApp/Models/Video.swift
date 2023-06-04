//
//  Video.swift
//  YoutubeaApp
//
//  Created by Marcin Dytko on 19/05/2023.
//

import Foundation

struct Video: Decodable {
    
    var videoId = ""
    var title = ""
    var description = ""
    var thumbnail = ""
    var published = Date()
    
    // Allow us to access the specific properties. just needeed properties
    enum CodingKeys: String, CodingKey {
        case snippet
        case thumbnails
        case high
        case resourceId
        case published = "publishedAt"
        case title
        case description
        case thumbnail = "url"
        case videoId
    }
    init() {
        self.videoId = "1234dae"
        self.title = "It's video"
        self.description = "this is descreption iandfpanpewnpiewepifwenwinewnweiawnepwniewpwafeawpni epianwfpiewapiwaei nwpafeeopwiw"
        self.thumbnail = "https://i.ytimg.com/vi/m4LT7_LDr5U/hqdefault.jpg?sqp=-oaymwEjCPYBEIoBSFryq4qpAxUIARUAAAAAGAElAADIQj0AgKJDeAE=&rs=AOn4CLBPtf8GAZctzo4JDNOkZjY8Zv2iyg"
        self.published = Date()
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        
        // Parse title
        self.title = try snippetContainer.decode(String.self, forKey: .title)
        // Parse despriton
        self.description = try snippetContainer.decode(String.self, forKey: .description)
        // parse date
        self.published = try snippetContainer.decode(Date.self, forKey: .published)
        // Prase thumbnails
        let thumbnailContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails)
        
        let highContainer = try thumbnailContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high)
        
        self.thumbnail = try highContainer.decode(String.self, forKey: .thumbnail)
        
        // parse video ID
        let resourceIdContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .resourceId)
        
        self.videoId = try resourceIdContainer.decode(String.self, forKey: .videoId)
        
    }
    
    
    
}

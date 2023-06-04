//
//  CacheManager.swift
//  YoutubeaApp
//
//  Created by Marcin Dytko on 19/05/2023.
//

import Foundation

class CacheManager {
    
    static var cache = [String : Data]()
    
    static func setVideoCache(_ url: String, _ data: Data?) {
        // Store the image data with url as key
        cache[url] = data
    }
    
    static func getVideoCache(_ url: String) -> Data? {
        // get the data for specified url
        return cache[url]
    }
}

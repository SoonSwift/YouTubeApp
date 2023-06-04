//
//  Response.swift
//  YoutubeaApp
//
//  Created by Marcin Dytko on 19/05/2023.
//

import Foundation

struct Response: Decodable {
    
    var items: [Video]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
    
    init(from decoder: Decoder) throws {
        let contariner = try decoder.container(keyedBy: CodingKeys.self)
        self.items = try contariner.decode([Video].self, forKey: .items)
    }
    
}
